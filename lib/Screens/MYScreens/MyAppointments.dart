import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/my_appointment_model.dart';

import 'package:patient/Screens/MYScreens/MyLabTest.dart';
import 'package:patient/Screens/MedicineProfile.dart';
import 'package:patient/Screens/ProductDetails.dart';
import 'package:patient/Screens/Products.dart';
import 'package:patient/Screens/booking_appointment.dart';
import 'package:patient/Screens/view_booking_details.dart';
import 'package:patient/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class _MyAppointmentsState extends State<MyAppointments> {
  late MyAppointmentsModel details;
  bool loading = true;
  Iterable<MyAppointmentsModelData> Details = [];

  MyAppointmentController _con = MyAppointmentController();
  Future initialize() async {
    await _con.getMyAppointments().then((value) {
      setState(() {
        details = value;
        Details = value.data.reversed;
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(FontAwesomeIcons.filter),
      //   backgroundColor: apptealColor,
      //   elevation: 20,
      //   splashColor: apptealColor,
      // ),
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
      body: (loading)
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
                          padding: const EdgeInsets.all(10.0),
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
                                                        .profile,
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  titleColumn(
                                                    title: 'Booking Id',
                                                    value:
                                                        Details.elementAt(index)
                                                            .booingId,
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
                                                      '\₹${Details.elementAt(index).fees}',
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
                                              bottomRight: Radius.circular(15)),
                                        ))),
                                    onPressed: () {
                                      Push(
                                          context,
                                          BookingAppointment(
                                              booking_id:
                                                  Details.elementAt(index)
                                                      .booingId,
                                              doctor_id:
                                                  Details.elementAt(index)
                                                      .doctorId)
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
                )
              ],
            ),
    );
  }
}
