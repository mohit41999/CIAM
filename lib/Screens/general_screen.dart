import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:patient/Screens/Home.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/Screens/search_screen.dart';
import 'package:patient/firebase/notification_handling.dart';
import 'package:patient/widgets/bottombar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'DoctorScreens/doctor_profile.dart';
import 'LabProfile.dart';
import 'MedicineProfile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      DoctorProfile(fromhome: false),
      // HomeScreen(),
      MedicineProfile(),
      LabProfile()
    ];
  }

  int _selected_index = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBody: true,
      //resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildScreens().elementAt(_selected_index),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            height: 70,
            decoration:
                BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
            width: MediaQuery.of(context).size.width,
            child: FABBottomAppBar(
              centerItemText: 'Search',
              selectedColor: appblueColor,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: (int index) {
                setState(() {
                  _selected_index = index;
                });
              },
              items: [
                FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
                FABBottomAppBarItem(iconData: Icons.person, text: 'Doctor'),
                FABBottomAppBarItem(
                    iconData: Icons.account_circle, text: 'Medicine'),
                FABBottomAppBarItem(iconData: Icons.more_horiz, text: 'Lab'),
              ],
              color: Colors.black,
              // backgroundColor: Colors.purple,
            ),
          ),
        ),
      ),
      // bottomNavigationBar: ClipRRect(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //     child: Container(
      //       height: 64,
      //       width: MediaQuery.of(context).size.width,
      //       child: FABBottomAppBar(
      //         centerItemText: 'Search',
      //         backgroundColor: Colors.transparent,
      //         selectedColor: appblueColor,
      //         notchedShape: CircularNotchedRectangle(),
      //         onTabSelected: (int index) {
      //           setState(() {
      //             _selected_index = index;
      //           });
      //         },
      //         items: [
      //           FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
      //           FABBottomAppBarItem(iconData: Icons.search, text: 'Doctor'),
      //           FABBottomAppBarItem(
      //               iconData: Icons.account_circle, text: 'Medicine'),
      //           FABBottomAppBarItem(iconData: Icons.more_horiz, text: 'Lab'),
      //         ],
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: FittedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            clipBehavior: Clip.antiAlias,
            // clipBehavior: Clip.hardEdge,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.5),
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: FloatingActionButton(
                  //isExtended: true,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                    // Push(context, SearchScreen());
                  },
                  child: Icon(
                    Icons.search,
                    size: 40,
                    color: appblueColor,
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar:
    );
  }
}
