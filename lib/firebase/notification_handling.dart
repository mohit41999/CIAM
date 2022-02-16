import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Screens/AGORA/video_call.dart';
import 'package:patient/Screens/accept_reject_call.dart';
import 'package:patient/Utils/APIIDS.dart';

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
      channelName = event.data['chanel_name'];
      print(event.data);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AcceptReject(channel_name: event.data['chanel_name'])));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // String? channel_name = event.notification!.title.toString();
      channelName = event.data['chanel_name'];
      print('onMessageOpenedApp');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AcceptReject(channel_name: event.data['chanel_name'])));
      // Navigator.of(context).push(
      //     context,
      //     );
      // Push(context, );
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      channelName = message.data['chanel_name'];
      print(message.data);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AcceptReject(channel_name: message.data['chanel_name'])));
    });

    // notificationhandler(context);
  }
}
