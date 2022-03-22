import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/package_available_lab_model.dart';
import 'package:patient/Models/LAB/package_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageController {
  Future<PackageAvailableLabModel> getAvailableLabs(String packageid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: 'get_packages_available_labs.php', params: {
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
        await PostData(PARAM_URL: 'get_package_details.php', params: {
      'token': Token,
      'user_id': preferences.getString('user_id'),
      'package_id': packageid
    });

    return PackageDetailsModel.fromJson(response);
  }
}
