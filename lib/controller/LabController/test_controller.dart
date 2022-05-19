import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/test_checkout_model.dart';
import 'package:patient/Models/coupons_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestController {
  Future<TestCheckoutModel> getTestCheckout(
      String labid, List<String> testids, String coupon) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    Map<String?, String?> params = {
      'token': Token,
      'user_id': preference.getString('user_id'),
      'lab_id': labid,
    };
    (coupon != '') ? params.addAll({'coupen_id': coupon}) : {};
    for (int i = 0; i < testids.length; i++) {
      print(i.toString() + '\n');
      params.addAll({'test_id[$i]': testids[i]});
    }
    // testids.forEach((element) {
    //   params.addAll({'test_id[]': element});
    // });
    print(params);

    var response =
        await PostData(PARAM_URL: 'confirm_test_order.php', params: params);
    return TestCheckoutModel.fromJson(response);
  }

  Future addTestOrder(String labid, List<String> testids, String couponId,
      String totalPrice) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    Map<String?, String?> params = {
      'token': Token,
      'user_id': preference.getString('user_id'),
      'lab_id': labid,
      'total_price': totalPrice,
      'coupen_id': couponId
    };

    for (int i = 0; i < testids.length; i++) {
      print(i.toString() + '\n');
      params.addAll({'test_id[$i]': testids[i]});
    }
    // testids.forEach((element) {
    //   params.addAll({'test_id[]': element});
    // });
    print(params);

    var response =
        await PostData(PARAM_URL: 'add_test_order.php', params: params);
    return response;
  }

  Future<CouponsModel> getCoupons(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await PostData(PARAM_URL: 'get_coupon_list.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
    });
    return CouponsModel.fromJson(response);
  }
}
