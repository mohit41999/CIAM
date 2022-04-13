import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

String username = "";
String password = "";
Future getRazorpaycred() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var response = await PostData(
      PARAM_URL: 'get_razorpay_keys.php',
      params: {'token': Token, 'user_id': preferences.getString('user_id')});
  username = response['data']['razorpay_key_id'];
  password = response['data']['razorpay_key_secret'];
  return response;
}

Future paywithWallet(String amount) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var response = await PostData(PARAM_URL: 'pay_with_wallet.php', params: {
    'token': Token,
    'user_id': preferences.getString('user_id'),
    'amount': amount
  });
  return response;
}
