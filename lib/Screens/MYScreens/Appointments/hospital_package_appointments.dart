import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/my_hospital_package_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/AppointmentController/appointmentController.dart';

class MyHospitalPackageAppointments extends StatefulWidget {
  const MyHospitalPackageAppointments({Key? key}) : super(key: key);

  @override
  State<MyHospitalPackageAppointments> createState() =>
      _MyHospitalPackageAppointmentsState();
}

class _MyHospitalPackageAppointmentsState
    extends State<MyHospitalPackageAppointments> {
  late MyHospitalPackageModel details;
  bool loading = true;
  List<MyHospitalPackageModelData> Details = [];

  AppointmentController _con = AppointmentController();

  Future initialize() async {
    await _con.getHospitalPackageBooking(context).then((value) {
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
      body: (Details.length == 0)
          ? Center(
              child: Text('No bookings Yet'),
            )
          : ListView.builder(
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
                      title: Text('${Details[index].packageCategory}',
                          style: GoogleFonts.montserrat(
                              color: appblueColor,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text('${Details[index].packageSubCategory}',
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
