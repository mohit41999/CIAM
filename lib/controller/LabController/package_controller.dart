import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/package_available_lab_model.dart';
import 'package:patient/Models/LAB/package_checkout_model.dart';
import 'package:patient/Models/LAB/package_details_model.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageController {
  Future<PackageAvailableLabModel> getAvailableLabs(String packageid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.get_packages_available_labs,
        params: {
          'token': Token,
          'user_id': preferences.getString('user_id'),
          'package_id': packageid,
          'city': preferences.getString('city')
        });

    return PackageAvailableLabModel.fromJson(response);
  }

  Future<PackageDetailsModel> getpackagedetails(String packageid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: AppEndPoints.get_package_details, params: {
      'token': Token,
      'user_id': preferences.getString('user_id'),
      'package_id': packageid
    });

    return PackageDetailsModel.fromJson(response);
  }

  Future<PackageCheckoutModel> getPackageCheckout(String packageid,
      String labId, String coupenId, String relative_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: AppEndPoints.confirm_package_order, params: {
      'token': Token,
      'user_id': preferences.getString('user_id'),
      'package_id': packageid,
      'lab_id': labId,
      'coupen_id': coupenId,
      'relative_id': relative_id
    });

    return PackageCheckoutModel.fromJson(response);
  }

  Future addPackageOrder(
      {required String packageid,
      required String labId,
      required String fees,
      required String coupon_discount,
      required String amountPaid,
      required String couponCode}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: AppEndPoints.add_package_order, params: {
      'token': Token,
      'user_id': preferences.getString('user_id'),
      'lab_id': labId,
      'package_id': packageid,
      'total_price': fees,
      'coupon_discount': coupon_discount,
      'ammount_paid': amountPaid,
      'coupon_code': couponCode
    });

    return response;
  }
}
