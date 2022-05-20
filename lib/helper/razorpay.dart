import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String username = "";
String password = "";
Future getRazorpaycred() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var response = await PostData(
      PARAM_URL: AppEndPoints.get_razorpay_keys,
      params: {'token': Token, 'user_id': preferences.getString('user_id')});
  username = response['data']['razorpay_key_id'];
  password = response['data']['razorpay_key_secret'];
  return response;
}

Future paywithWallet(String amount) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var response = await PostData(
      PARAM_URL: AppEndPoints.pay_with_wallet,
      params: {
        'token': Token,
        'user_id': preferences.getString('user_id'),
        'amount': amount
      });
  return response;
}

void payment(int amount, Razorpay _razorpay) async {
  var authn = 'Basic ' + base64Encode(utf8.encode('${username}:${password}'));
  Object? orderOptions = {
    "amount": amount,
    "currency": "INR",
    "receipt": "Receipt no. 1",
    "payment_capture": 1,
  };
  var headers = {
    'content-type': 'application/json',
    'Authorization': authn,
  };
  // final client = HttpClient();
  var res = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),
      headers: headers, body: json.encode(orderOptions));

  print(jsonDecode(res.body).toString() +
      '======================================');

  String order_id = jsonDecode(res.body)['id'].toString();

  Map<String, dynamic> checkoutOptions = {
    'key': username,
    'amount': amount,
    "currency": "INR",
    'name': '',
    'description': '',
    'order_id': order_id, // Generate order_id using Orders API
    'timeout': 3000,
  };
  try {
    _razorpay.open(checkoutOptions);
  } catch (e) {}
}
