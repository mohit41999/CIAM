import 'package:flutter/material.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_1.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_3.dart';
import 'package:patient/Screens/LabProfile.dart';
import 'package:patient/Screens/MedicineProfile.dart';
import 'package:patient/Screens/Products.dart';
import 'package:patient/Screens/Signup.dart';
import 'package:patient/Screens/patient_home_page_4.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/navigation_drawer.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/common_row.dart';
import 'package:patient/widgets/patient_home_page_4_alert_box.dart';

class PatientHomePage4 extends StatefulWidget {
  const PatientHomePage4({Key? key}) : super(key: key);

  @override
  _PatientHomePage4State createState() => _PatientHomePage4State();
}

class _PatientHomePage4State extends State<PatientHomePage4> {
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) => GestureDetector(
              child: Container(
                width: 30,
                height: 30,
                child: Center(
                  child: Icon(
                    Icons.menu,
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
              onTap: () {
                setState(() {
                  Scaffold.of(context).openDrawer();
                });
              },
            ),
          ),
        ),
      ),
      drawer: commonDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 40,
                  width: double.infinity,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Color(0xff161616).withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Search',
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Color(0xff161616).withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF6F6F6),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(2, 5),
                            ),
                          ],
                        ),
                        // height: 100,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Heal At Home',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: appblueColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 160,
                                    child: Text(
                                      'India\'s largest home health care company',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Color(0xff161616),
                                      ),
                                    ),
                                  ),
                                  commonBtn(
                                    s: 'Book Now',
                                    bgcolor: appblueColor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      // Push(context, DoctorProfile1());
                                      patientpg4alertbox(context, _search);
                                    },
                                    width: 120,
                                    height: 30,
                                    textSize: 12,
                                    borderRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset('assets/pngs/nursedoctor.png')
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 370,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: commonRow(
                      Title: 'Health Care Services',
                      subTitle: 'View all',
                      value: DoctorProfile(fromhome: true),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // maxCrossAxisExtent: 100,
                          childAspectRatio: 0.77 / 1,
                          // crossAxisSpacing: 10,
                          // mainAxisSpacing: 10,
                          crossAxisCount: 2),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              Push(context, DoctorProfile3());
                            },
                            child: Container(
                              height: 126,
                              width: 154,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(2, 5),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/pngs/Icon material-face.png',
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Physiotherapy',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 600,
              color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color(0xffF6F6F6),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(2, 5),
                            ),
                          ],
                        ),
                        // height: 100,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Heal At Home',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: appblueColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 160,
                                    child: Text(
                                      'India\'s largest home health care company',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Color(0xff161616),
                                      ),
                                    ),
                                  ),
                                  commonBtn(
                                    s: 'Know More',
                                    bgcolor: Color(0xff161616).withOpacity(0.6),
                                    textColor: Colors.white,
                                    onPressed: () {
                                      // Push(context, DoctorProfile1());
                                    },
                                    width: 120,
                                    height: 30,
                                    textSize: 12,
                                    borderRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset('assets/pngs/nursedoctor.png')
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
