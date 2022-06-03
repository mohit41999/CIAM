import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Screens/biometric_authenticate.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/firebase/fcm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NavigationController.dart';

class SignInController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  void clearControllers() {
    email.clear();

    password.clear();
  }

  login(BuildContext context, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', value['data']['id']);
    FireBaseSetup().storefcmToken();
    print(prefs.getString('user_id'));

    PushReplacement(context, BiometricAuthenticate());
  }

  Future<void> SignIn(BuildContext context) async {
    var loader = ProgressView(context);
    loader.show();
    var response = await PostData(PARAM_URL: ApiEndPoints.login, params: {
      'token': Token,
      'email': email.text,
      'password': password.text,
    });
    loader.dismiss();
    if (response['status']) {
      login(context, response);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response['message']),
        duration: Duration(seconds: 1),
      ));
    }
  }
}
