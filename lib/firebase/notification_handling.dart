import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Screens/AGORA/video_call.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile.dart';
import 'package:patient/controller/NavigationController.dart';

class FirebaseNotificationHandling {
  Future sendNotification({required String user_id}) async {
    var response = await http.post(
        Uri.parse(
            'http://ciam.notionprojects.tech/api/patient/send_notification.php'),
        body: {'token': Token, 'user_id': user_id});
    print(response.body);
    var Response = jsonDecode(response.body);
    return Response;
  }

  late FirebaseMessaging _firebaseMessaging;

  void setupFirebase(BuildContext context) {
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getInitialMessage().then((value) {
      // String channel_name = value!.notification!.title.toString();
      // Push(context, VideoCall(channelName: 'testing'));
    });
    notificationhandler(context);
  }

  void notificationhandler(BuildContext context) {
    //
    FirebaseMessaging.onMessage.listen((event) {
      // String channel_name = event.notification!.title.toString();
      Push(context, VideoCall(channelName: 'testing'));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // String channel_name = event.notification!.title.toString();
      Push(context, DoctorProfile(fromhome: false));
    });
  }
}
