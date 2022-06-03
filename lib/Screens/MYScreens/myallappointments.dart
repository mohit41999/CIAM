import 'package:flutter/material.dart';
import 'package:patient/Screens/MYScreens/Appointments/health_care_appointments.dart';
import 'package:patient/Screens/MYScreens/Appointments/hospital_package_appointments.dart';
import 'package:patient/Screens/MYScreens/MyAppointments.dart';

import '../../Utils/colorsandstyles.dart';
import '../../widgets/commonAppBarLeading.dart';
import '../../widgets/common_app_bar_title.dart';

class MyAllAppointments extends StatefulWidget {
  const MyAllAppointments({Key? key}) : super(key: key);

  @override
  State<MyAllAppointments> createState() => _MyAllAppointmentsState();
}

class _MyAllAppointmentsState extends State<MyAllAppointments>
    with SingleTickerProviderStateMixin {
  late TabController allcontroller;

  @override
  void initState() {
    // TODO: implement initState

    allcontroller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    allcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: commonAppBarTitleText(appbarText: 'My Appointments'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        titleSpacing: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                isScrollable: true,
                padding: EdgeInsets.all(8),
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: appblueColor),
                    insets: EdgeInsets.all(-1)),
                labelColor: appblueColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Text("Doctor"),
                  // Text("Lab"),
                  Text("Hospital Package"),
                  Text("Health Care"),
                ],
                controller: allcontroller,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                MyAppointments(),
                // MyLabAppointments(),
                MyHospitalPackageAppointments(),
                MyHealthCareAppointments(),
              ],
              controller: allcontroller,
            ),
          )
        ],
      ),
    );
  }
}
