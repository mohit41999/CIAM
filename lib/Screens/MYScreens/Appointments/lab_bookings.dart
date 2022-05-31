import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/LAB/my_lab_packages_model.dart';
import 'package:patient/Models/LAB/my_lab_test_model.dart';
import 'package:patient/Models/MyModels/my_appointment_model.dart';
import 'package:patient/Screens/booking_appointment.dart';
import 'package:patient/Screens/cancel_screen.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/AppointmentController/appointmentController.dart';
import 'package:patient/controller/My%20Screens%20Controller/my_appointments_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_column.dart';

class MyLabAppointments extends StatefulWidget {
  const MyLabAppointments({Key? key}) : super(key: key);

  @override
  _MyLabAppointmentsState createState() => _MyLabAppointmentsState();
}

class _MyLabAppointmentsState extends State<MyLabAppointments>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                labelPadding: EdgeInsets.only(right: 0, left: 0, bottom: 8),
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: appblueColor),
                    insets: EdgeInsets.all(-1)),
                labelColor: appblueColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Text('Tests'),
                  Text('Packages'),
                ],
                controller: _controller,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TestAppointments(),
                  PackagesAppointments(),
                ]),
          )
        ],
      ),
    );
  }
}

class TestAppointments extends StatefulWidget {
  const TestAppointments({Key? key}) : super(key: key);

  @override
  _TestAppointmentsState createState() => _TestAppointmentsState();
}

class _TestAppointmentsState extends State<TestAppointments> {
  late MyLabTestBooking details;
  bool loading = true;
  Iterable<MyLabTestBookingData> Details = [];

  AppointmentController _con = AppointmentController();
  Future initialize() async {
    await _con.getlabTestBooking(context).then((value) {
      setState(() {
        details = value;
        Details = value.data;
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
    return
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(FontAwesomeIcons.filter),
        //   backgroundColor: apptealColor,
        //   elevation: 20,
        //   splashColor: apptealColor,
        // ),

        (loading)
            ? Center(child: CircularProgressIndicator())
            : (details.data.length == 0)
                ? Center(child: Text('No tests Booked'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: Details.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 8.0,
                                    bottom: (index + 1 == Details.length)
                                        ? navbarht + 20
                                        : 8.0),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: const Offset(2, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 130,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          Details.elementAt(
                                                                  index)
                                                              .labImage,
                                                        ),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        titleColumn(
                                                          title: 'Booking Id',
                                                          value:
                                                              Details.elementAt(
                                                                      index)
                                                                  .booingId,
                                                        ),
                                                        titleColumn(
                                                          value:
                                                              Details.elementAt(
                                                                      index)
                                                                  .labName,
                                                          title: 'Lab Name',
                                                        ),
                                                        titleColumn(
                                                          value:
                                                              Details.elementAt(
                                                                      index)
                                                                  .location,
                                                          title: 'Location',
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0,
                                                                left: 8),
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                Details.elementAt(
                                                                        index)
                                                                    .tests
                                                                    .toString()
                                                                    .replaceAll(
                                                                        '[', '')
                                                                    .replaceAll(
                                                                        ']',
                                                                        ''),
                                                                style: GoogleFonts.lato(
                                                                    color: Color(
                                                                        0xffD68100),
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Text(
                                                              '\₹${Details.elementAt(index).ammountPaid}',
                                                              style: GoogleFonts.poppins(
                                                                  color: Color(
                                                                      0xff252525),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 40,
                                      //   width: double.infinity,
                                      //   child: TextButton(
                                      //     style: ButtonStyle(
                                      //         backgroundColor:
                                      //             MaterialStateProperty.all<
                                      //                 Color>(appblueColor),
                                      //         shape: MaterialStateProperty.all<
                                      //                 RoundedRectangleBorder>(
                                      //             RoundedRectangleBorder(
                                      //           borderRadius: BorderRadius.only(
                                      //               bottomLeft:
                                      //                   Radius.circular(15),
                                      //               bottomRight:
                                      //                   Radius.circular(15)),
                                      //         ))),
                                      //     onPressed: () {
                                      //
                                      //     },
                                      //     child: Text(
                                      //       'View Booking Details',
                                      //       style: GoogleFonts.montserrat(
                                      //           fontSize: 12,
                                      //           color: Colors.white,
                                      //           letterSpacing: 1,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //   ),
                                      // )
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: commonBtn(
                                            s: 'Cancel',
                                            height: 30,
                                            textSize: 12,
                                            width: 100,
                                            bgcolor: Colors.white,
                                            textColor: Colors.red,
                                            borderColor: Colors.red,
                                            borderWidth: 2,
                                            onPressed: () {
                                              Push(context, CancelScreen(),
                                                  withnav: false);
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
  }
}

class PackagesAppointments extends StatefulWidget {
  const PackagesAppointments({Key? key}) : super(key: key);

  @override
  _PackagesAppointmentsState createState() => _PackagesAppointmentsState();
}

class _PackagesAppointmentsState extends State<PackagesAppointments> {
  late MyLabPackageBooking details;
  bool loading = true;
  Iterable<MyLabPackageBookingDatum> Details = [];

  AppointmentController _con = AppointmentController();
  Future initialize() async {
    await _con.getlabPackageBooking(context).then((value) {
      setState(() {
        details = value;
        Details = value.data;
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
    return (loading)
        ? Center(child: CircularProgressIndicator())
        : (Details.length == 0)
            ? Center(
                child: Text('No completed appointments'),
              )
            : Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: Details.length,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  top: 8.0,
                                  bottom: (index + 1 == Details.length)
                                      ? navbarht + 20
                                      : 8.0),
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: const Offset(2, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 130,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        Details.elementAt(index)
                                                            .labImage,
                                                      ),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      titleColumn(
                                                        title: 'Booking Id',
                                                        value:
                                                            Details.elementAt(
                                                                    index)
                                                                .booingId,
                                                      ),
                                                      titleColumn(
                                                        value:
                                                            Details.elementAt(
                                                                    index)
                                                                .labName,
                                                        title: 'Lab Name',
                                                      ),
                                                      titleColumn(
                                                        value:
                                                            Details.elementAt(
                                                                    index)
                                                                .location,
                                                        title: 'Location',
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          Details.elementAt(
                                                                  index)
                                                              .packageName,
                                                          style: GoogleFonts.lato(
                                                              color: Color(
                                                                  0xffD68100),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          '\₹${Details.elementAt(index).ammountPaid}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Color(
                                                                      0xff252525),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: commonBtn(
                                          s: 'Cancel',
                                          height: 30,
                                          textSize: 12,
                                          width: 100,
                                          bgcolor: Colors.white,
                                          textColor: Colors.red,
                                          borderColor: Colors.red,
                                          borderWidth: 2,
                                          onPressed: () {
                                            Push(context, CancelScreen(),
                                                withnav: false);
                                          }),
                                    )
                                    // SizedBox(
                                    //   height: 40,
                                    //   width: double.infinity,
                                    //   child: TextButton(
                                    //     style: ButtonStyle(
                                    //         backgroundColor:
                                    //             MaterialStateProperty.all<
                                    //                 Color>(appblueColor),
                                    //         shape: MaterialStateProperty.all<
                                    //                 RoundedRectangleBorder>(
                                    //             RoundedRectangleBorder(
                                    //           borderRadius: BorderRadius.only(
                                    //               bottomLeft:
                                    //                   Radius.circular(15),
                                    //               bottomRight:
                                    //                   Radius.circular(15)),
                                    //         ))),
                                    //     onPressed: () {
                                    //       Push(
                                    //           context,
                                    //           BookingAppointment(
                                    //               booking_id:
                                    //                   Details.elementAt(index)
                                    //                       .bookingId,
                                    //               doctor_id:
                                    //                   Details.elementAt(index)
                                    //                       .doctorId),
                                    //           withnav: false
                                    //           // ViewBookingDetails(
                                    //           //   booking_id: Details.elementAt(index)
                                    //           //       .booingId,
                                    //           // )
                                    //           );
                                    //     },
                                    //     child: Text(
                                    //       'View Booking Details',
                                    //       style: GoogleFonts.montserrat(
                                    //           fontSize: 12,
                                    //           color: Colors.white,
                                    //           letterSpacing: 1,
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
  }
}
