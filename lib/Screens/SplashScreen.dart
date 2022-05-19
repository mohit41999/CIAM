import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile.dart';
import 'package:patient/Screens/SignInScreen.dart';
import 'package:patient/Screens/biometric_authenticate2.dart';
import 'package:patient/Screens/general_screen.dart';
import 'package:patient/controller/home_controller.dart';
import 'package:patient/firebase/fcm.dart';
import 'package:patient/firebase/notification_handling.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:video_player/video_player.dart';

import 'biometric_authenticate.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  late VideoPlayerController controller;

  Future<void> navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.get('user_id'));
    timer = Timer(
        Duration(seconds: 4),
        () => (prefs.get('user_id').toString() == null.toString())
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignInScreen()))
            : (prefs.get('isbiometric').toString() == 'yes')
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BiometricAuthenticate2()))
                : Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => GeneralScreen())));
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.asset('assets/video/splash.mp4');

    controller.initialize().then((value) {
      setState(() {});
    });
  }

  FireBaseSetup fireBaseSetup = FireBaseSetup();
  @override
  void initState() {
    loadVideoPlayer();
    navigate();
    fireBaseSetup.storefcmToken();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose callleddd');
    controller.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    controller.play();
    return Scaffold(
      body: VideoPlayer(controller),
      // body: Stack(
      //   children: [
      //     Align(
      //         alignment: Alignment.topLeft,
      //         child: Container(
      //           height: 200,
      //           width: 150,
      //           decoration: BoxDecoration(
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Color(0xffFF2442),
      //                     blurRadius: 20,
      //                     spreadRadius: 40)
      //               ],
      //               color: Color(0xffFF2442),
      //               borderRadius:
      //                   BorderRadius.only(bottomRight: Radius.circular(200))),
      //         )),
      //     Align(
      //         alignment: Alignment.topRight,
      //         child: Container(
      //           height: 200,
      //           width: 200,
      //           decoration: BoxDecoration(
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Color(0xffFFC069),
      //                     blurRadius: 20,
      //                     spreadRadius: 15)
      //               ],
      //               color: Color(0xffFFC069),
      //               borderRadius:
      //                   BorderRadius.only(bottomLeft: Radius.circular(200))),
      //         )),
      //     Align(
      //         alignment: Alignment.bottomLeft,
      //         child: Container(
      //           height: 180,
      //           width: 180,
      //           decoration: BoxDecoration(
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Color(0xff085385),
      //                     blurRadius: 20,
      //                     spreadRadius: 30)
      //               ],
      //               color: Color(0xff085385),
      //               borderRadius:
      //                   BorderRadius.only(topRight: Radius.circular(200))),
      //         )),
      //     Align(
      //         alignment: Alignment.centerRight,
      //         child: Container(
      //           height: 200,
      //           width: 80,
      //           decoration: BoxDecoration(
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Color(0xff9A671A),
      //                     blurRadius: 20,
      //                     spreadRadius: 30)
      //               ],
      //               color: Color(0xff9A671A).withOpacity(0.1),
      //               borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(200),
      //                   bottomLeft: Radius.circular(200))),
      //         )),
      //     Container(
      //       width: double.infinity,
      //       height: double.infinity,
      //       decoration: BoxDecoration(boxShadow: [
      //         BoxShadow(
      //             color: Colors.white.withOpacity(0.7),
      //             blurRadius: 10,
      //             spreadRadius: 20)
      //       ]),
      //       child: Center(child: Image.asset('assets/pngs/logo.png')),
      //     )
      //   ],
      // ),
    );
  }
}
