import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/my_appointment_model.dart';
import 'package:patient/Screens/booking_appointment.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/My%20Screens%20Controller/my_appointments_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/title_column.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({Key? key}) : super(key: key);

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments>
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
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'My Appointments'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
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
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: appblueColor),
                    insets: EdgeInsets.all(-1)),
                labelColor: appblueColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Text('Completed'),
                  Text('Upcoming'),
                ],
                controller: _controller,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _controller, children: [
              CompletedAppointments(),
              UpcomingAppointments(),
            ]),
          )
        ],
      ),
    );
  }
}

class UpcomingAppointments extends StatefulWidget {
  const UpcomingAppointments({Key? key}) : super(key: key);

  @override
  _UpcomingAppointmentsState createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  late MyAppointmentsModel details;
  bool loading = true;
  Iterable<MyAppointmentsModelData> Details = [];

  MyAppointmentController _con = MyAppointmentController();
  Future initialize() async {
    await _con.getUpcoming().then((value) {
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
                              height: 170,
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
                                                          .profileImage,
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    titleColumn(
                                                      title: 'Booking Id',
                                                      value: Details.elementAt(
                                                              index)
                                                          .bookingId,
                                                    ),
                                                    titleColumn(
                                                      value: Details.elementAt(
                                                              index)
                                                          .doctorName,
                                                      title: 'Doctor Name',
                                                    ),
                                                    titleColumn(
                                                      value: Details.elementAt(
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
                                                        Details.elementAt(index)
                                                            .status,
                                                        style: GoogleFonts.lato(
                                                            color: Color(
                                                                0xffD68100),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '\₹${Details.elementAt(index).consultancyFees}',
                                                        style:
                                                            GoogleFonts.poppins(
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
                                  SizedBox(
                                    height: 40,
                                    width: double.infinity,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  appblueColor),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
                                          ))),
                                      onPressed: () {
                                        Push(
                                            context,
                                            BookingAppointment(
                                                booking_id:
                                                    Details.elementAt(index)
                                                        .bookingId,
                                                doctor_id:
                                                    Details.elementAt(index)
                                                        .doctorId),
                                            withnav: false
                                            // ViewBookingDetails(
                                            //   booking_id: Details.elementAt(index)
                                            //       .booingId,
                                            // )
                                            );
                                      },
                                      child: Text(
                                        'View Booking Details',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Colors.white,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
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

class CompletedAppointments extends StatefulWidget {
  const CompletedAppointments({Key? key}) : super(key: key);

  @override
  _CompletedAppointmentsState createState() => _CompletedAppointmentsState();
}

class _CompletedAppointmentsState extends State<CompletedAppointments> {
  late MyAppointmentsModel details;
  bool loading = true;
  Iterable<MyAppointmentsModelData> Details = [];

  MyAppointmentController _con = MyAppointmentController();
  Future initialize() async {
    await _con.getCompleted().then((value) {
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
                          height: 170,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                      .profileImage,
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                titleColumn(
                                                  title: 'Booking Id',
                                                  value:
                                                      Details.elementAt(index)
                                                          .bookingId,
                                                ),
                                                titleColumn(
                                                  value:
                                                      Details.elementAt(index)
                                                          .doctorName,
                                                  title: 'Doctor Name',
                                                ),
                                                titleColumn(
                                                  value:
                                                      Details.elementAt(index)
                                                          .location,
                                                  title: 'Location',
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    Details.elementAt(index)
                                                        .status,
                                                    style: GoogleFonts.lato(
                                                        color:
                                                            Color(0xffD68100),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '\₹${Details.elementAt(index).consultancyFees}',
                                                    style: GoogleFonts.poppins(
                                                        color:
                                                            Color(0xff252525),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                              SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              appblueColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                      ))),
                                  onPressed: () {
                                    Push(
                                        context,
                                        BookingAppointment(
                                            booking_id: Details.elementAt(index)
                                                .bookingId,
                                            doctor_id: Details.elementAt(index)
                                                .doctorId),
                                        withnav: false
                                        // ViewBookingDetails(
                                        //   booking_id: Details.elementAt(index)
                                        //       .booingId,
                                        // )
                                        );
                                  },
                                  child: Text(
                                    'View Booking Details',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.white,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
