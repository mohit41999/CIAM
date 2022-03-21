import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/test_checkout_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestController {
  Future<TestCheckoutModel?> getTestCheckout(
      String labid, List<String> testids) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    Map<String?, String?> params = {
      'token': Token,
      'user_id': preference.getString('user_id'),
      'lab_id': labid,
    };
    for (int i = 0; i < testids.length; i++) {
      print(i.toString() + '\n');
      params.addAll({'test_id[]': testids[i]});
    }
    // testids.forEach((element) {
    //   params.addAll({'test_id[]': element});
    // });
    print(params);

    // var response = await PostData(PARAM_URL: 'confirm_test_order.php', params: {
    //
    // });
    // return TestCheckoutModel.fromJson(response);
  }
}
