import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/all_labs_model.dart';
import 'package:patient/Models/LAB/all_packages_model.dart';
import 'package:patient/Models/LAB/all_test_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LABProfileController {
  late AllPackagesModel allPackages;
  late AllTestModel allTests;
  late AllLabsModel allLabs;
  bool packagesLoading = true;
  bool testloading = true;
  bool labloading = true;

  Future<AllPackagesModel> getallPackages() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_all_packages.php',
        params: {'user_id': preferences.getString('user_id'), 'token': Token});
    return AllPackagesModel.fromJson(response);
  }

  Future<AllTestModel> getallTests() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_all_test.php',
        params: {'user_id': preferences.getString('user_id'), 'token': Token});
    return AllTestModel.fromJson(response);
  }

  Future<AllLabsModel> getallLabs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(PARAM_URL: 'get_all_labs.php', params: {
      'user_id': preferences.getString('user_id'),
      'token': Token,
      'city': preferences.getString('city')
    });
    return AllLabsModel.fromJson(response);
  }
}
