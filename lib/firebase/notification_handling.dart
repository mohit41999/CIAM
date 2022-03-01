import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Screens/AGORA/video_call.dart';

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

  void setupFirebase(BuildContext context) {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((event) {
      print('onMessage ' + event.toString());

      print(event.data);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VideoCallPage(channelName: event.data['chanel_name'])));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('onMessageOpenedApp');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VideoCallPage(channelName: event.data['chanel_name'])));
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      print(message.data);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VideoCallPage(channelName: message.data['chanel_name'])));
    });
  }
}
