import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/view_booking_details.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/view_booking_details_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/details_tile.dart';
import 'package:patient/widgets/doctor_profile_row.dart';
import 'package:patient/widgets/title_column.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewBookingDetails extends StatefulWidget {
  final String booking_id;
  const ViewBookingDetails({Key? key, required this.booking_id})
      : super(key: key);

  @override
  _ViewBookingDetailsState createState() => _ViewBookingDetailsState();
}

class _ViewBookingDetailsState extends State<ViewBookingDetails> {
  Color textColor = Color(0xff161616);
  TextEditingController reviewController = TextEditingController();
  double _value = 5;
  late ViewBookingDetailsModel? details;
  bool loading = true;
  ViewBookingDetailsController _con = ViewBookingDetailsController();
  initialize() async {
    details = await _con.getViewDetails(widget.booking_id, context);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (loading)
            ? Text('')
            : Text(
                'Dr. ' + details!.data.doctorName.toUpperCase(),
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: appblueColor,
                    fontWeight: FontWeight.bold),
              ),
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 272,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Speciality',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                details!.data.specialty,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: appblueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
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
                            title: ' Patient Name',
                            value: details!.data.patientName,
                          ),
                          doctorProfileRow(
                            title: ' Patient Location',
                            value: details!.data.patientLocation,
                          ),
                          doctorProfileRow(
                            title: 'clinic Location',
                            value: details!.data.clinicLocation,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 350,
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            doctorProfileRow(
                              title: 'Booking ID',
                              value: details!.data.bookingId,
                            ),
                            doctorProfileRow(
                              title: 'Booking Status',
                              value: details!.data.bookingStatus,
                            ),
                            doctorProfileRow(
                              title: 'Booking Date',
                              value: details!.data.bookedDate,
                            ),
                            doctorProfileRow(
                              title: ' Booking Date',
                              value: details!.data.bookedServiceTime,
                            ),
                            doctorProfileRow(
                              title: 'Amount ',
                              value: details!.data.totalAmount,
                            ),
                            doctorProfileRow(
                              title: 'Payment Status',
                              value: details!.data.amountStatus,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                spreadRadius: 3)
                          ],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: apptealColor, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TitleEnterField('Add Review',
                                    'Add Review', reviewController),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Icon(
                                    Icons.star,
                                    color: apptealColor,
                                  )),
                                  Expanded(
                                    flex: 5,
                                    child: Slider(
                                        activeColor: appblueColor,
                                        inactiveColor: Colors.grey,
                                        divisions: 5,
                                        label: _value.toString(),
                                        value: _value,
                                        max: 5,
                                        min: 0,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonBtn(
                                        width: 70,
                                        height: 30,
                                        textSize: 12,
                                        borderRadius: 2,
                                        s: 'Cancel',
                                        bgcolor: apptealColor,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Pop(context);
                                        }),
                                    commonBtn(
                                        width: 70,
                                        height: 30,
                                        textSize: 12,
                                        borderRadius: 2,
                                        s: 'Ok',
                                        bgcolor: apptealColor,
                                        textColor: Colors.white,
                                        onPressed: () async {
                                          var loader = ProgressView(context);
                                          loader.show();
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          PostData(
                                              PARAM_URL: 'add_review.php',
                                              params: {
                                                'token': Token,
                                                'user_id':
                                                    prefs.getString('user_id'),
                                                'doctor_id':
                                                    details!.data.Doctor_Id,
                                                'message':
                                                    reviewController.text,
                                                'rating': _value.toString()
                                              }).then((value) {
                                            loader.dismiss();
                                            value['status']
                                                ? success(context, value)
                                                : ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            value['message'])));
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
    );
  }
  // {
  //   return Scaffold(
  //     appBar: AppBar(
  //       centerTitle: true,
  //       title: commonAppBarTitleText(appbarText: 'Booking Details'),
  //       backgroundColor: appAppBarColor,
  //       elevation: 0,
  //       leading: Builder(
  //           builder: (context) => commonAppBarLeading(
  //               iconData: Icons.arrow_back_ios_new,
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               })),
  //     ),
  //     body: (loading)
  //         ? Center(child: CircularProgressIndicator())
  //         : ListView(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Container(
  //                   height: MediaQuery.of(context).size.height * 0.7,
  //                   decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       boxShadow: [
  //                         BoxShadow(
  //                             color: Colors.grey.withOpacity(0.5),
  //                             blurRadius: 2,
  //                             spreadRadius: 3)
  //                       ],
  //                       borderRadius: BorderRadius.circular(15),
  //                       border: Border.all(color: apptealColor, width: 1)),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       crossAxisAlignment: CrossAxisAlignment.stretch,
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 DetailsTile(
  //                                     title: 'BookingId',
  //                                     value: details!.data.bookingId),
  //                                 DetailsTile(
  //                                     title: 'Booking Date',
  //                                     value: details!.data.bookedDate),
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               height: 15,
  //                             ),
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 DetailsTile(
  //                                     title: 'Booked Service Time',
  //                                     value: details!.data.bookedServiceTime
  //                                         .substring(0, 5)),
  //                                 DetailsTile(
  //                                     title: 'Booking Status',
  //                                     value: details!.data.bookingStatus),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                         Divider(
  //                           color: apptealColor,
  //                           thickness: 2,
  //                         ),
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 DetailsTile(
  //                                     title: 'Doctor Name',
  //                                     value: details!.data.doctorName
  //                                         .toUpperCase()),
  //                                 DetailsTile(
  //                                     title: 'Patient Name',
  //                                     value: details!.data.patientName
  //                                         .toUpperCase()),
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               height: 10,
  //                             ),
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 DetailsTile(
  //                                     title: 'Clinic Location',
  //                                     value: details!.data.clinicLocation
  //                                         .toUpperCase()),
  //                                 DetailsTile(
  //                                     title: 'Patient Location',
  //                                     value: details!.data.patientLocation
  //                                         .toUpperCase()),
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               height: 10,
  //                             ),
  //                             DetailsTile(
  //                                 title: 'Doctor Speciality',
  //                                 value: details!.data.specialty.toUpperCase()),
  //                           ],
  //                         ),
  //                         Divider(
  //                           color: apptealColor,
  //                           thickness: 2,
  //                         ),
  //
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             DetailsTile(
  //                                 title: 'Total Amount',
  //                                 value: "\₹${details!.data.totalAmount}"),
  //                             DetailsTile(
  //                                 title: 'Amount Status',
  //                                 value: details!.data.amountStatus),
  //                           ],
  //                         ),
  //
  //                         // Text(details!.data.patientName),
  //                         // Text(details!.data.bookingId),
  //                         // Text(details!.data.amountStatus),
  //                         // Text(details!.data.totalAmount),
  //                         // Text(details!.data.clinicLocation),
  //                         // Text(details!.data.bookedServiceTime),
  //                         // Text(details!.data.patientLocation),
  //                         // Text(details!.data.bookingStatus),
  //                         // Text(details!.data.specialty),
  //                         // Text(details!.data.bookedDate),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       boxShadow: [
  //                         BoxShadow(
  //                             color: Colors.grey.withOpacity(0.5),
  //                             blurRadius: 2,
  //                             spreadRadius: 3)
  //                       ],
  //                       borderRadius: BorderRadius.circular(15),
  //                       border: Border.all(color: apptealColor, width: 1)),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       crossAxisAlignment: CrossAxisAlignment.stretch,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: TitleEnterField(
  //                               'Add Review', 'Add Review', reviewController),
  //                         ),
  //                         Row(
  //                           children: [
  //                             Expanded(
  //                                 child: Icon(
  //                               Icons.star,
  //                               color: apptealColor,
  //                             )),
  //                             Expanded(
  //                               flex: 5,
  //                               child: Slider(
  //                                   activeColor: appblueColor,
  //                                   inactiveColor: Colors.grey,
  //                                   divisions: 5,
  //                                   label: _value.toString(),
  //                                   value: _value,
  //                                   max: 5,
  //                                   min: 0,
  //                                   onChanged: (value) {
  //                                     setState(() {
  //                                       _value = value;
  //                                     });
  //                                   }),
  //                             ),
  //                           ],
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               commonBtn(
  //                                   width: 70,
  //                                   height: 30,
  //                                   textSize: 12,
  //                                   borderRadius: 2,
  //                                   s: 'Cancel',
  //                                   bgcolor: apptealColor,
  //                                   textColor: Colors.white,
  //                                   onPressed: () {
  //                                     Pop(context);
  //                                   }),
  //                               commonBtn(
  //                                   width: 70,
  //                                   height: 30,
  //                                   textSize: 12,
  //                                   borderRadius: 2,
  //                                   s: 'Ok',
  //                                   bgcolor: apptealColor,
  //                                   textColor: Colors.white,
  //                                   onPressed: () async {
  //                                     var loader = ProgressView(context);
  //                                     loader.show();
  //                                     SharedPreferences prefs =
  //                                         await SharedPreferences.getInstance();
  //                                     PostData(
  //                                         PARAM_URL: 'add_review.php',
  //                                         params: {
  //                                           'token': Token,
  //                                           'user_id':
  //                                               prefs.getString('user_id'),
  //                                           'doctor_id':
  //                                               details!.data.Doctor_Id,
  //                                           'message': reviewController.text,
  //                                           'rating': _value.toString()
  //                                         }).then((value) {
  //                                       loader.dismiss();
  //                                       value['status']
  //                                           ? success(context, value)
  //                                           : ScaffoldMessenger.of(context)
  //                                               .showSnackBar(SnackBar(
  //                                                   content: Text(
  //                                                       value['message'])));
  //                                     });
  //                                   }),
  //                             ],
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //   );
  // }
}
