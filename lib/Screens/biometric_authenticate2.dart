import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/API%20repo/local_auth_api.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/firebase/notification_handling.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';

import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DoctorScreens/doctor_profile.dart';
import 'general_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class BiometricAuthenticate2 extends StatefulWidget {
  const BiometricAuthenticate2({Key? key}) : super(key: key);

  @override
  _BiometricAuthenticate2State createState() => _BiometricAuthenticate2State();
}

class _BiometricAuthenticate2State extends State<BiometricAuthenticate2> {
  @override
  void initState() {
    // FirebaseNotificationHandling().setupFirebase(context);
    // setupFirebase(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
        title: commonAppBarTitle(),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
      body: GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final isAuthenticated = await LocalAuthApi.authenticate(context);
            if (isAuthenticated) {
              // prefs.setString('isbiometric', 'yes');
              Push(context, GeneralScreen());
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Try Again')));
            }
          },
          child: (Platform.isAndroid)
              ? Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              'assets/pngs/Icon ionic-md-finger-print.png',
                              height: 90),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Press This FingerPrint to Start Scanning',
                            style: GoogleFonts.montserrat(
                                color: apptealColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/pngs/Icon material-face.png',
                              height: 90),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Press This Face to Start Scanning FaceID',
                            style: GoogleFonts.montserrat(
                                color: apptealColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}
