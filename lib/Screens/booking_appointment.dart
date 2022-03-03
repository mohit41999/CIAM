import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/confirm_booking_model.dart';
import 'package:patient/Screens/AGORA/video_call.dart';
import 'package:patient/Screens/PaymentScreens/payment_confirmation_screen.dart';
import 'package:patient/Screens/TermsAndConditions.dart';
import 'package:patient/Screens/pdf.dart';
import 'package:patient/Screens/text_page.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/DoctorProdileController/confirm_booking_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/firebase/notification_handling.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/doctor_profile_row.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingAppointment extends StatefulWidget {
  final String booking_id;
  final String doctor_id;
  const BookingAppointment(
      {Key? key, required this.booking_id, required this.doctor_id})
      : super(key: key);

  @override
  _BookingAppointmentState createState() => _BookingAppointmentState();
}

class _BookingAppointmentState extends State<BookingAppointment> {
  double reviewrating = 4;
  Color textColor = Color(0xff161616);
  ConfirmBookingController _con = ConfirmBookingController();
  late ConfirmBookingModel confirmData;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool loading = true;
  bool downloading = false;
  var progress = "";
  late DateTime appointmentdate;
  late int differenceInDays;
  late Timer timer;
  late DateTime today = DateTime.now();
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  List patientReports = [];
  late Directory externalDir;
  Future getPatientReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(PARAM_URL: 'get_doctor_reports.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'booking_id': widget.booking_id
    });

    return response;
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails('channel id', 'channel name',
        channelDescription: 'channel description',
        priority: Priority.high,
        importance: Importance.max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess
            ? 'File has been downloaded successfully!'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
        DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile(String pdfUrl) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    Dio dio = Dio();

    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }
      var savepath = (pdfUrl.contains('.jpg'))
          ? dirloc + convertCurrentDateTimeToString() + ".jpg"
          : dirloc + convertCurrentDateTimeToString() + ".pdf";

      try {
        FileUtils.mkdir([dirloc]);
        var response = await dio.download(pdfUrl, savepath,
            onReceiveProgress: (receivedBytes, totalBytes) {
          print('here 1');
          setState(() {
            downloading = true;
            progress =
                ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
            print(progress);
          });
          print('here 2');
        });
        result['isSuccess'] = response.statusCode == 200;
        result['filePath'] = savepath;
      } catch (e) {
        print('catch catch catch');
        result['error'] = e.toString();
        print(e);
      } finally {
        await _showNotification(result);
      }

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        path = savepath;
      });
      print(path);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Download Complete'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonBtn(
                          height: 40,
                          borderRadius: 5,
                          width: 90,
                          textSize: 12,
                          s: 'Close',
                          bgcolor: apptealColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Pop(context);
                          }),
                      commonBtn(
                          height: 40,
                          textSize: 12,
                          borderRadius: 5,
                          width: 90,
                          s: 'Open',
                          bgcolor: appblueColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                            Push(context, OpenPdf(url: path), withnav: false);
                          })
                    ],
                  ),
                ],
              ));
      print('here give alert-->completed');
    } else {
      setState(() {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile(pdfUrl);
        };
      });
    }
  }

  void initialize() {
    getPatientReports().then((value) {
      setState(() {
        (value['data'] == null)
            ? patientReports = []
            : patientReports = value['data'];
      });
    });
    _con
        .getconfirmBooking(context, widget.doctor_id, widget.booking_id)
        .then((value) {
      setState(() {
        confirmData = value;
        appointmentdate = DateTime(
            int.parse(confirmData.data.Date.substring(0, 4)),
            int.parse(confirmData.data.Date.substring(5, 7)),
            int.parse(confirmData.data.Date.substring(8, 10)),
            int.parse(confirmData.data.Date.substring(11, 13)),
            int.parse(confirmData.data.Date.substring(14, 16)),
            00);
        differenceInDays = DateTime.now().difference(appointmentdate).inMinutes;
        timer = Timer.periodic(Duration(seconds: 5), (timer) {
          if (mounted) {
            setState(() {
              _con
                  .getconfirmBooking(
                      context, widget.doctor_id, widget.booking_id)
                  .then((value) {
                setState(() {
                  confirmData = value;
                });
              });
              print('5 secs');
              differenceInDays =
                  DateTime.now().difference(appointmentdate).inMinutes;
              print(differenceInDays);
            });
          }
        });

        loading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  void _onSelectNotification(String? json) async {
    final obj = jsonDecode(json!);

    if (obj['isSuccess']) {
      print(obj['filePath'] + 'lllll');
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (loading)
              ? Center(child: CircularProgressIndicator())
              : (downloading)
                  ? Center(
                      child: Container(
                        height: 120.0,
                        width: 200.0,
                        child: Card(
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Downloading File: $progress',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 260,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        confirmData.data.doctorProfile),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 10),
                              child: Text(
                                confirmData.data.doctorName,
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    color: appblueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: (confirmData.data.amountStatus == 'Confirm')
                                ? 250
                                : 180,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Confirmation',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    color: textColor.withOpacity(0.4),
                                    thickness: 1,
                                  ),
                                  doctorProfileRow(
                                    title: 'Booking ID',
                                    value: confirmData.data.bookingId,
                                  ),
                                  doctorProfileRow(
                                    title: 'Doctor Name',
                                    value: confirmData.data.doctorName,
                                  ),
                                  doctorProfileRow(
                                    title: 'Specialty',
                                    value: confirmData.data.specialty,
                                  ),
                                  (confirmData.data.amountStatus == 'Confirm')
                                      ? commonBtn(
                                          s: 'Add Review',
                                          bgcolor: Colors.white,
                                          textColor: appblueColor,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: TitleEnterField(
                                                        'Review',
                                                        'Review',
                                                        reviewController,
                                                        maxLines: 10,
                                                      ),
                                                      content:
                                                          RatingBar.builder(
                                                        initialRating:
                                                            reviewrating,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: apptealColor,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          reviewrating = rating;
                                                          print(reviewrating);
                                                        },
                                                      ),
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            commonBtn(
                                                              height: 40,
                                                              s: 'Cancel',
                                                              borderRadius: 5,
                                                              borderColor:
                                                                  Colors.red,
                                                              borderWidth: 1,
                                                              bgcolor:
                                                                  Colors.white,
                                                              textColor:
                                                                  Colors.red,
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              width: 70,
                                                              textSize: 12,
                                                            ),
                                                            commonBtn(
                                                              height: 40,
                                                              borderColor:
                                                                  appblueColor,
                                                              borderWidth: 1,
                                                              borderRadius: 5,
                                                              s: 'Submit',
                                                              bgcolor:
                                                                  Colors.white,
                                                              textColor:
                                                                  appblueColor,
                                                              onPressed: () {
                                                                add_review();
                                                              },
                                                              width: 70,
                                                              textSize: 12,
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ));
                                          },
                                          borderWidth: 1,
                                          borderColor: appblueColor,
                                          borderRadius: 10,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 143,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Patient Details',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    color: textColor.withOpacity(0.4),
                                    thickness: 1,
                                  ),
                                  doctorProfileRow(
                                    title: 'Patient Name',
                                    value: confirmData
                                        .data.patientDetails.patientName,
                                  ),
                                  doctorProfileRow(
                                    title: 'Age',
                                    value: confirmData
                                        .data.patientDetails.patientAge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          (confirmData.data.amountStatus.toString() ==
                                  'Confirm')
                              ? Container(
                                  height: 549,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Booking Details',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              color: textColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: textColor.withOpacity(0.4),
                                          thickness: 1,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              child: Text(
                                                'Booking Date and Time',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Color(0xff161616)
                                                        .withOpacity(0.6)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text('-'),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.65,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                        text: '',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff161616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                '   ${confirmData.data.bookingDate.toString().substring(8, 10)}/ ${confirmData.data.bookingDate.substring(5, 7)}/ ${confirmData.data.bookingDate.substring(0, 4)}    \n   ${confirmData.data.bookedServiceTime.substring(0, 5)} ',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    color:
                                                                        apptealColor,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          )
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        doctorProfileRow(
                                          title: 'Total Amount',
                                          value:
                                              '\₹${confirmData.data.totalAmount}',
                                        ),
                                        doctorProfileRow(
                                          title: 'Status',
                                          value: confirmData.data.amountStatus,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: Text(
                                                  'Download Report File',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Color(0xff161616)
                                                          .withOpacity(0.6)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text('-'),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  (patientReports.length == 0)
                                                      ? ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                          content: Text(
                                                              'No reports available'),
                                                          backgroundColor:
                                                              appblueColor,
                                                        ))
                                                      : showDialog(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  AlertDialog(
                                                                    content:
                                                                        Container(
                                                                      height:
                                                                          250.0, // Change as per your requirement
                                                                      width:
                                                                          300.0,
                                                                      child: ListView.builder(
                                                                          itemCount: patientReports.length,
                                                                          shrinkWrap: true,
                                                                          itemBuilder: (context, index) {
                                                                            return (patientReports[index]['reportfile'].toString() == '')
                                                                                ? Container()
                                                                                : Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            patientReports[index]['reportfile'].toString().replaceAll('http://ciam.notionprojects.tech/assets/uploaded/doctorReport/', ''),
                                                                                            style: GoogleFonts.montserrat(fontSize: 10),
                                                                                          ),
                                                                                        ),
                                                                                        GestureDetector(
                                                                                            onTap: () {
                                                                                              Pop(context);
                                                                                              downloadFile(patientReports[index]['reportfile']);
                                                                                            },
                                                                                            child: Image.asset('assets/pngs/Icon feather-download.png'))
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                          }),
                                                                    ),
                                                                  ));
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.65,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10.0),
                                                        child: Text(
                                                          'Report',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 12,
                                                                  color:
                                                                      apptealColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                      Image.asset(
                                                          'assets/pngs/Icon feather-download.png')
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        commonBtn(
                                          borderColor: apptealColor,
                                          borderWidth: 2,
                                          s: 'Add Report',
                                          bgcolor: Colors.white,
                                          textColor: apptealColor,
                                          onPressed: () {
                                            pickFile();
                                          },
                                          borderRadius: 10,
                                        ),
                                        (reportList.length == 0)
                                            ? Container()
                                            : Column(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            reportList.length,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Text(
                                                              reportList[index]
                                                                  .path
                                                                  .toString());
                                                        }),
                                                  ),
                                                  commonBtn(
                                                      borderColor: appblueColor,
                                                      borderWidth: 2,
                                                      borderRadius: 10,
                                                      s: 'Upload',
                                                      bgcolor: Colors.white,
                                                      textColor: appblueColor,
                                                      onPressed: () {
                                                        submitmultiple()
                                                            .then((value) {
                                                          setState(() {
                                                            reportList = [];
                                                          });
                                                        });
                                                      })
                                                ],
                                              ),
                                        commonBtn(
                                          borderColor: apptealColor,
                                          borderWidth: 2,
                                          s: 'Add Comments',
                                          bgcolor: Colors.white,
                                          textColor: apptealColor,
                                          onPressed: () {
                                            addcomments();
                                          },
                                          borderRadius: 10,
                                        ),
                                        commonBtn(
                                          s: 'Chat',
                                          bgcolor: Colors.white,
                                          textColor: apptealColor,
                                          onPressed: () {
                                            print(widget.doctor_id);
                                            Push(
                                                context,
                                                TextPage(
                                                  doctorName: confirmData
                                                      .data.doctorName,
                                                  doctorid: widget.doctor_id,
                                                ),
                                                withnav: false);
                                          },
                                          height: 45,
                                          borderRadius: 8,
                                          borderColor: apptealColor,
                                          borderWidth: 2,
                                        ),
                                        (confirmData.data
                                                    .video_consultancy_complete ==
                                                'false')
                                            ? (DateTime(
                                                            DateTime.now().year,
                                                            DateTime.now()
                                                                .month,
                                                            DateTime.now().day)
                                                        .toString()
                                                        .substring(0, 10) ==
                                                    confirmData
                                                        .data.bookingDate)
                                                ? (differenceInDays >= -5 &&
                                                        differenceInDays <= 20)
                                                    ? commonBtn(
                                                        s: 'Start Video',
                                                        bgcolor: appblueColor,
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          FirebaseNotificationHandling()
                                                              .sendNotification(
                                                                  user_id:
                                                                      confirmData
                                                                          .data
                                                                          .doctorid)
                                                              .then((value) {
                                                            if (!value[
                                                                'status']) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              value['message']));
                                                            } else {
                                                              Push(
                                                                  context,
                                                                  VideoCallPage(
                                                                    channelName:
                                                                        value['data']
                                                                            [
                                                                            'Channel Name'],
                                                                  ),
                                                                  withnav:
                                                                      false);
                                                            }
                                                          });
                                                        },
                                                        height: 45,
                                                        borderRadius: 8,
                                                      )
                                                    : SizedBox()
                                                : SizedBox()
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 300,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Booking Details',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              color: textColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: textColor.withOpacity(0.4),
                                          thickness: 1,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              child: Text(
                                                'Booking Date and Time',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Color(0xff161616)
                                                        .withOpacity(0.6)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text('-'),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.65,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                        text: '',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff161616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                '   ${confirmData.data.bookingDate.toString().substring(8, 10)}/ ${confirmData.data.bookingDate.substring(5, 7)}/ ${confirmData.data.bookingDate.substring(0, 4)}    \n   ${confirmData.data.bookedServiceTime.substring(0, 5)} ',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    color:
                                                                        apptealColor,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          )
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        doctorProfileRow(
                                          title: 'Total Amount',
                                          value:
                                              '\₹${confirmData.data.totalAmount}',
                                        ),
                                        commonBtn(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TermsAndConditions(
                                                          amount: confirmData
                                                              .data.totalAmount,
                                                          booking_id:
                                                              confirmData.data
                                                                  .bookingId,
                                                        ))).then((value) {
                                              setState(() {
                                                loading = true;
                                                print(
                                                    'thissssssssssssssss=======');
                                                initialize();
                                              });
                                            });
                                          },
                                          s: 'Terms and Conditions',
                                          textColor: appblueColor,
                                          bgcolor: Colors.white,
                                          borderRadius: 10,
                                          height: 30,
                                          textSize: 12,
                                          borderColor: appblueColor,
                                          borderWidth: 2,
                                        ),
                                        commonBtn(
                                          s: 'Proceed',
                                          bgcolor: appblueColor,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            pushNewScreen(
                                              context,
                                              screen: PaymentConfirmationScreen(
                                                amount: confirmData
                                                    .data.totalAmount,
                                                booking_id:
                                                    confirmData.data.bookingId,
                                                terms: true,
                                              ),
                                              withNavBar:
                                                  false, // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .cupertino,
                                            ).then((value) {
                                              setState(() {
                                                loading = true;
                                                print(
                                                    'thissssssssssssssss=======');
                                                initialize();
                                              });
                                            });
                                          },
                                          // width: 153,
                                          // height: 30,
                                          textSize: 12,
                                          borderRadius: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: navbarht + 20,
                          ),
                        ],
                      ),
                    ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 30),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: appblueColor,
                      size: 20,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(2, 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future submitmultiple() async {
    for (int i = 0; i < reportList.length; i++) {
      uploadMultiple(i);
    }
  }

  Future uploadMultiple(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loader = ProgressView(context);
    loader.show();
    // if user don't pick any thi
    await PostDataWithImage(
            PARAM_URL: 'upload_patient_document.php',
            params: {
              'token': Token,
              'user_id': prefs.getString('user_id')!,
              'booking_id': widget.booking_id,
            },
            imagePath: reportList[i].path.toString(),
            imageparamName: 'reportfile')
        .then((value) {
      loader.dismiss();
      value['status']
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Document uploaded successfully'),
              backgroundColor: apptealColor,
            ))
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Document was not uploaded, try again later'),
              backgroundColor: Colors.red,
            ));
    });
  }

  List<File> reportList = [];
  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
        ]);
    if (result == null) {
      return;
    } else {
      setState(() {
        reportList = result.paths.map((path) => File(path!)).toList();
      });
    }
    // ng then do nothing just return.
  }

  TextEditingController _commments = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  Future add_review() async {
    if (reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enter Review Text')));
    } else {
      var loader = ProgressView(context);
      loader.show();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      PostData(PARAM_URL: 'add_review.php', params: {
        'token': Token,
        'user_id': prefs.getString('user_id'),
        'doctor_id': confirmData.data.doctorid,
        'message': reviewController.text,
        'rating': reviewrating.toString()
      }).then((value) {
        reviewController.clear();
        loader.dismiss();
        value['status']
            ? success(context, value)
            : ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value['message'])));
      });
    }
  }

  Future addcomments() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: TitleEnterField(
                'Comments',
                'Comments',
                _commments,
                maxLines: 30,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonBtn(
                          width: 100,
                          height: 40,
                          textSize: 12,
                          borderRadius: 5,
                          s: 'Cancel',
                          bgcolor: Colors.black,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      commonBtn(
                          width: 100,
                          height: 40,
                          borderRadius: 5,
                          textSize: 12,
                          s: 'Submit',
                          bgcolor: apptealColor,
                          textColor: Colors.white,
                          onPressed: () async {
                            var loader = ProgressView(context);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            loader.show();
                            PostData(
                                PARAM_URL: 'upload_patient_document.php',
                                params: {
                                  'token': Token,
                                  'user_id': prefs.getString('user_id')!,
                                  'booking_id': widget.booking_id,
                                  'comments': _commments.text
                                }).then((value) {
                              loader.dismiss();
                              value['status']
                                  ? ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content:
                                          Text('Comment added successfully'),
                                      backgroundColor: apptealColor,
                                    ))
                                  : ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content: Text(
                                          'Comment wan not added, try again later'),
                                      backgroundColor: Colors.red,
                                    ));
                              Navigator.pop(context);
                            });
                          })
                    ],
                  ),
                )
              ],
            ));
  }
}
