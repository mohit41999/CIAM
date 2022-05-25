import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/my_health_care_model.dart';
import 'package:patient/Models/my_hospital_package_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/AppointmentController/appointmentController.dart';

class MyHealthCareAppointments extends StatefulWidget {
  const MyHealthCareAppointments({Key? key}) : super(key: key);

  @override
  State<MyHealthCareAppointments> createState() =>
      _MyHealthCareAppointmentsState();
}

class _MyHealthCareAppointmentsState extends State<MyHealthCareAppointments> {
  late MyHealthCareModel details;
  bool loading = true;
  List<MyHealthCareModelDatum> Details = [];

  AppointmentController _con = AppointmentController();

  Future initialize() async {
    await _con.getHealthCareBooking(context).then((value) {
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
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: Details.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Text(
                    'Booking Id: ${Details[index].booingId}',
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  title: Text('${Details[index].homecareCategory}',
                      style: GoogleFonts.montserrat(
                          color: appblueColor, fontWeight: FontWeight.bold)),
                  subtitle: Text('${Details[index].homecareSubCategory}',
                      style: GoogleFonts.montserrat(color: apptealColor)),
                  // children: [
                  //   Text(Details[index].booingId),
                  //   Text(Details[index].packageCategory),
                  //   Text(Details[index].packageSubCategory),
                  // ],
                ),
              ),
            );
          }),
    );
  }
}
