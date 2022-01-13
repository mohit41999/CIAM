import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/confirm_booking_model.dart';
import 'package:patient/Screens/booking_appointment.dart';
import 'package:patient/Utils/colorsandstyles.dart';

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
  bool loading = true;

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

  @override
  void initState() {
    // TODO: implement initState

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
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 260,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/pngs/Rectangle 69.png'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
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
                        height: 272,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                title: 'Confirmation',
                                value: confirmData.data.bookingId,
                              ),
                              doctorProfileRow(
                                title: 'Specialty',
                                value: confirmData.data.specialty,
                              ),
                              doctorProfileRow(
                                title: 'Doctor Name',
                                value: confirmData.data.doctorName,
                              ),
                              doctorProfileRow(
                                title: 'Booking for',
                                value: confirmData.data.Booking_For,
                              ),
                              doctorProfileRow(
                                title: 'Status of Booking',
                                value: confirmData.data.bookingStatus,
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                value: confirmData.data.patientName,
                              ),
                              doctorProfileRow(
                                title: 'Location',
                                value: confirmData.data.patientLocation,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 549,
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child: Text(
                                      'Booked Service time',
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
                                    width: MediaQuery.of(context).size.width /
                                        1.65,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: '',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Color(0xff161616),
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '   ${confirmData.data.bookedServiceTime.substring(0, 5)} am',
                                                  style: GoogleFonts.montserrat(
                                                      color: apptealColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                              doctorProfileRow(
                                title: 'Clinic Address',
                                value: confirmData.data.clinicLocation,
                              ),
                              doctorProfileRow(
                                title: 'Total Amount',
                                value: '\₹${confirmData.data.totalAmount}',
                              ),
                              doctorProfileRow(
                                title: 'Admin Fees',
                                value:
                                    '\₹${double.parse(confirmData.data.totalAmount) * 1 / 10}',
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child: Text(
                                      'Amount Status',
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
                                    width: MediaQuery.of(context).size.width /
                                        1.65,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          confirmData.data.amountStatus,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Color(0xff161616),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        commonBtn(
                                          s: 'Pay Now',
                                          bgcolor: appblueColor,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            _con.confirmBookingRequest(
                                                context, widget.booking_id);
                                          },
                                          width: 153,
                                          height: 30,
                                          textSize: 12,
                                          borderRadius: 0,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
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
                                  GestureDetector(
                                    onTap: () {
                                      downloadFile(
                                          confirmData.data.download_report,
                                          'pdf',
                                          'downloads');
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.65,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              'Document',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: apptealColor,
                                                  fontWeight: FontWeight.bold),
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
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
                                    width: MediaQuery.of(context).size.width /
                                        1.65,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Text(
                                            'Report',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: apptealColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Image.asset(
                                            'assets/pngs/Icon feather-download.png')
                                      ],
                                    ),
                                  )
                                ],
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
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40),
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
}
