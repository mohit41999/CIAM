import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/patient_profile_model.dart';
import 'package:patient/Models/relative_model.dart';
import 'package:patient/Screens/SignInScreen.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API repo/api_end_points.dart';
import '../NavigationController.dart';

class RelativeSettingController {
  bool isSelected = false;
  TextEditingController relation = TextEditingController();
  TextEditingController relative_name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();

  TextEditingController bloodGroup = TextEditingController();
  TextEditingController maritalStatus = TextEditingController();
  List<Map> genderType = [
    {'type': 'Male', 'value': 'm'},
    {'type': 'Female', 'value': 'f'}
  ];
  var dropDownvalue;
  Future<void> submit(BuildContext context) async {
    if (relation.text.isEmpty ||
        relative_name.text.isEmpty ||
        age.text.isEmpty ||
        gender.text.isEmpty ||
        bloodGroup.text.isEmpty ||
        maritalStatus.text.isEmpty) {
      isSelected = false;
    } else {
      var loader = ProgressView(context);
      loader.show();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? user_id = prefs.getString('user_id');
      print(user_id);
      Map<String, String> bodyParam = {
        'token': Token,
        'user_id': user_id.toString(),
        'relation': relation.text,
        'relative_name': relative_name.text,
        'gender': gender.text,
        'age': age.text,
        'blood_group': bloodGroup.text,
        'marital_status': maritalStatus.text,
      };

      var response = await PostData(
          PARAM_URL: AppEndPoints.add_relative, params: bodyParam);

      loader.dismiss();
      if (response['status']) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response['message'])));
        isSelected = false;
      } else {
        failure(context, response);
      }
      clearContollers();
    }
  }

  Future<RelativeModel> getrelativedata(BuildContext context) async {
    // var loader = ProgressView(context);
    // loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    print(user_id);
    var response =
        await PostData(PARAM_URL: AppEndPoints.get_relative, params: {
      'token': Token,
      'user_id': user_id.toString(),
    });
    print('-=========>>>>>' + response.toString());
    // loader.dismiss();
    return RelativeModel.fromJson(response);
  }

  void clearContollers() {
    maritalStatus.clear();
    bloodGroup.clear();
    gender.clear();
    age.clear();
    relative_name.clear();
    relation.clear();
    dropDownvalue = null;
  }
}
