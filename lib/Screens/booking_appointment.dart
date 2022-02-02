import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/confirm_booking_model.dart';
import 'package:patient/Screens/PaymentScreens/payment_confirmation_screen.dart';
import 'package:open_file/open_file.dart';
import 'package:patient/Screens/booking_appointment.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_utils/file_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/controller/DoctorProdileController/confirm_booking_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/doctor_profile_row.dart';

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
  Color textColor = Color(0xff161616);
  ConfirmBookingController _con = ConfirmBookingController();
  late ConfirmBookingModel confirmData;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool loading = true;
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  late Directory externalDir;
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

      try {
        FileUtils.mkdir([dirloc]);
        var response = await dio.download(
            pdfUrl, dirloc + convertCurrentDateTimeToString() + ".pdf",
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
        result['filePath'] = dirloc + convertCurrentDateTimeToString() + ".pdf";
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
        path = dirloc + convertCurrentDateTimeToString() + ".pdf";
      });
      print(path);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Download Complete'),
                actions: [
                  commonBtn(
                      s: 'OK',
                      bgcolor: apptealColor,
                      textColor: Colors.white,
                      onPressed: () {
                        Pop(context);
                      })
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
    _con
        .getconfirmBooking(context, widget.doctor_id, widget.booking_id)
        .then((value) {
      setState(() {
        confirmData = value;
        loading = false;
      });
    });
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
                                  // doctorProfileRow(
                                  //   title: 'Booking for',
                                  //   value: confirmData.data.Booking_For,
                                  // ),
                                  // doctorProfileRow(
                                  //   title: 'Status of Booking',
                                  //   value: confirmData.data.bookingStatus,
                                  // ),
                                  commonBtn(
                                    s: 'Add Review',
                                    bgcolor: Colors.white,
                                    textColor: appblueColor,
                                    onPressed: () {},
                                    borderWidth: 1,
                                    borderColor: appblueColor,
                                    borderRadius: 10,
                                  ),
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
                                                  // RichText(
                                                  //   text: TextSpan(
                                                  //       text: 'End Time',
                                                  //       style: GoogleFonts.montserrat(
                                                  //           fontSize: 12,
                                                  //           color: Color(0xff161616),
                                                  //           fontWeight: FontWeight.bold),
                                                  //       children: <TextSpan>[
                                                  //         TextSpan(
                                                  //           text: '     29 Sep. 12:00 AM',
                                                  //           style: GoogleFonts.montserrat(
                                                  //               color: apptealColor,
                                                  //               fontSize: 12,
                                                  //               fontWeight:
                                                  //                   FontWeight.bold),
                                                  //         )
                                                  //       ]),
                                                  // ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        // doctorProfileRow(
                                        //   title: 'Clinic Address',
                                        //   value: confirmData.data.clinicLocation,
                                        // ),
                                        doctorProfileRow(
                                          title: 'Total Amount',
                                          value:
                                              '\₹${confirmData.data.totalAmount}',
                                        ),
                                        doctorProfileRow(
                                          title: 'Status',
                                          value: confirmData.data.amountStatus,
                                        ),
                                        // doctorProfileRow(
                                        //   title: 'Admin Fees',
                                        //   value:
                                        //       '\₹${double.parse(confirmData.data.totalAmount) * 1 / 10}',
                                        // ),

                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Container(
                                        //       width:
                                        //           MediaQuery.of(context).size.width / 5,
                                        //       child: Text(
                                        //         'Amount Status',
                                        //         style: GoogleFonts.montserrat(
                                        //             fontSize: 12,
                                        //             color: Color(0xff161616)
                                        //                 .withOpacity(0.6)),
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 15,
                                        //     ),
                                        //     Text('-'),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     Container(
                                        //       width: MediaQuery.of(context).size.width /
                                        //           1.65,
                                        //       child: Row(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.spaceBetween,
                                        //         children: [
                                        //           Text(
                                        //             confirmData.data.amountStatus,
                                        //             style: GoogleFonts.montserrat(
                                        //                 fontSize: 12,
                                        //                 color: Color(0xff161616),
                                        //                 fontWeight: FontWeight.bold),
                                        //           ),
                                        //           commonBtn(
                                        //             s: 'Pay Now',
                                        //             bgcolor: appblueColor,
                                        //             textColor: Colors.white,
                                        //             onPressed: () {
                                        //               _con.confirmBookingRequest(
                                        //                   context, widget.booking_id);
                                        //             },
                                        //             width: 153,
                                        //             height: 30,
                                        //             textSize: 12,
                                        //             borderRadius: 0,
                                        //           )
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        GestureDetector(
                                          onTap: () {
                                            downloadFile(confirmData
                                                .data.patient_document);
                                          },
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
                                                  'Uploaded Document',
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
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Text(
                                                        'Document',
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
                                              )
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     downloadFile(
                                              //         confirmData
                                              //             .data.download_report,
                                              //         'pdf',
                                              //         'downloads');
                                              //   },
                                              //   child: Container(
                                              //     width: MediaQuery.of(context)
                                              //             .size
                                              //             .width /
                                              //         1.65,
                                              //     child: Row(
                                              //       children: [
                                              //         Padding(
                                              //           padding:
                                              //               const EdgeInsets
                                              //                       .only(
                                              //                   right: 10.0),
                                              //           child: Text(
                                              //             'Document',
                                              //             style: GoogleFonts
                                              //                 .montserrat(
                                              //                     fontSize: 12,
                                              //                     color:
                                              //                         apptealColor,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .bold),
                                              //           ),
                                              //         ),
                                              //         Image.asset(
                                              //             'assets/pngs/Icon feather-download.png')
                                              //       ],
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
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
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.65,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                              )
                                            ],
                                          ),
                                        ),
                                        commonBtn(
                                          borderColor: apptealColor,
                                          borderWidth: 2,
                                          s: 'Upload Document',
                                          bgcolor: Colors.white,
                                          textColor: apptealColor,
                                          onPressed: () {
                                            pickFile().then((value) {
                                              setState(() {
                                                initialize();
                                              });
                                            });
                                          },
                                          textSize: 12,
                                          borderRadius: 10,
                                        ),
                                        commonBtn(
                                          s: 'Chat',
                                          bgcolor: Colors.white,
                                          textColor: apptealColor,
                                          onPressed: () {},
                                          height: 45,
                                          borderRadius: 8,
                                          borderColor: apptealColor,
                                          borderWidth: 2,
                                        ),
                                        commonBtn(
                                          s: 'Start Video',
                                          bgcolor: appblueColor,
                                          textColor: Colors.white,
                                          onPressed: () {},
                                          height: 45,
                                          borderRadius: 8,
                                        )
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
                                                  // RichText(
                                                  //   text: TextSpan(
                                                  //       text: 'End Time',
                                                  //       style: GoogleFonts.montserrat(
                                                  //           fontSize: 12,
                                                  //           color: Color(0xff161616),
                                                  //           fontWeight: FontWeight.bold),
                                                  //       children: <TextSpan>[
                                                  //         TextSpan(
                                                  //           text: '     29 Sep. 12:00 AM',
                                                  //           style: GoogleFonts.montserrat(
                                                  //               color: apptealColor,
                                                  //               fontSize: 12,
                                                  //               fontWeight:
                                                  //                   FontWeight.bold),
                                                  //         )
                                                  //       ]),
                                                  // ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        // doctorProfileRow(
                                        //   title: 'Clinic Address',
                                        //   value: confirmData.data.clinicLocation,
                                        // ),
                                        doctorProfileRow(
                                          title: 'Total Amount',
                                          value:
                                              '\₹${confirmData.data.totalAmount}',
                                        ),
                                        // doctorProfileRow(
                                        //   title: 'Admin Fees',
                                        //   value:
                                        //       '\₹${double.parse(confirmData.data.totalAmount) * 1 / 10}',
                                        // ),

                                        commonBtn(
                                          s: 'Pay Now',
                                          bgcolor: appblueColor,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            Push(context,
                                                PaymentConfirmationScreen());
                                            // _con
                                            //     .confirmBookingRequest(
                                            //         context, widget.booking_id)
                                            //     .then((value) {
                                            //   _con
                                            //       .getconfirmBooking(context,
                                            //           widget.doctor_id, widget.booking_id)
                                            //       .then((value) {
                                            //     setState(() {
                                            //       confirmData = value;
                                            //     });
                                            //   });
                                            // });
                                          },
                                          // width: 153,
                                          // height: 30,
                                          textSize: 12,
                                          borderRadius: 0,
                                        ),
                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     Container(
                                        //       width:
                                        //           MediaQuery.of(context).size.width / 5,
                                        //       child: Text(
                                        //         'Amount Status',
                                        //         style: GoogleFonts.montserrat(
                                        //             fontSize: 12,
                                        //             color: Color(0xff161616)
                                        //                 .withOpacity(0.6)),
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 15,
                                        //     ),
                                        //     Text('-'),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     Container(
                                        //       width: MediaQuery.of(context).size.width /
                                        //           1.65,
                                        //       child: Row(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.spaceBetween,
                                        //         children: [
                                        //           Text(
                                        //             confirmData.data.amountStatus,
                                        //             style: GoogleFonts.montserrat(
                                        //                 fontSize: 12,
                                        //                 color: Color(0xff161616),
                                        //                 fontWeight: FontWeight.bold),
                                        //           ),
                                        //           commonBtn(
                                        //             s: 'Pay Now',
                                        //             bgcolor: appblueColor,
                                        //             textColor: Colors.white,
                                        //             onPressed: () {
                                        //               _con.confirmBookingRequest(
                                        //                   context, widget.booking_id);
                                        //             },
                                        //             width: 153,
                                        //             height: 30,
                                        //             textSize: 12,
                                        //             borderRadius: 0,
                                        //           )
                                        //         ],
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),

                                        // GestureDetector(
                                        //   onTap: () {
                                        //     downloadFile(
                                        //         confirmData
                                        //             .data.download_report,
                                        //         'pdf',
                                        //         'downloads');
                                        //   },
                                        //   child: Container(
                                        //     width: MediaQuery.of(context)
                                        //             .size
                                        //             .width /
                                        //         1.65,
                                        //     child: Row(
                                        //       children: [
                                        //         Padding(
                                        //           padding:
                                        //               const EdgeInsets
                                        //                       .only(
                                        //                   right: 10.0),
                                        //           child: Text(
                                        //             'Document',
                                        //             style: GoogleFonts
                                        //                 .montserrat(
                                        //                     fontSize: 12,
                                        //                     color:
                                        //                         apptealColor,
                                        //                     fontWeight:
                                        //                         FontWeight
                                        //                             .bold),
                                        //           ),
                                        //         ),
                                        //         Image.asset(
                                        //             'assets/pngs/Icon feather-download.png')
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 12,
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

  Future pickFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    //
    // if (result != null) {
    //   _con.file = File(result.files.single.path!);
    // } else {
    //   // User canceled the picker
    // }
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    // if user don't pick any thi
    await PostDataWithImage(
        PARAM_URL: 'upload_patient_document.php',
        params: {
          'token': Token,
          'user_id': prefs.getString('user_id')!,
          'booking_id': widget.booking_id,
          'comments': ''
        },
        imagePath: result.files.first.path.toString(),
        imageparamName: 'documentfile'); // ng then do nothing just return.
  }
}
