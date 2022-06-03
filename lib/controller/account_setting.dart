import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API repo/api_end_points.dart';

class AccountSettingController {
  TextEditingController old_password = TextEditingController();
  TextEditingController new_password = TextEditingController();

  Future<void> changesPassword(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await PostData(PARAM_URL: ApiEndPoints.account_setting, params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'old_password': old_password.text,
      'new_password': new_password.text,
    }).then((value) {
      (value['status'])
          ? success(context, value)
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value['message']),
              duration: Duration(seconds: 1),
            ));
    });
  }
}
