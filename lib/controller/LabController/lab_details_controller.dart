import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/lab_details_model.dart';
import 'package:patient/Models/LAB/lab_test_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LabdetailsController {
  late LabDetailsModel labDetails;
  late LabTestsModel labTests;
  Future<LabDetailsModel> getLabDetails(String labid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(PARAM_URL: 'get_lab_details.php', params: {
      'token': Token,
      'user_id': preferences.getString('user_id'),
      'lab_id': labid
    });

    return LabDetailsModel.fromJson(response);
  }

  Future<LabTestsModel> getLabtests(String labid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(PARAM_URL: 'get_lab_tests.php', params: {
      'token': Token,
      'user_id': preferences.getString('user_id'),
      'lab_id': labid
    });

    return LabTestsModel.fromJson(response);
  }
}
