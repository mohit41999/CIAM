import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/patient_profile_model.dart';
import 'package:patient/Screens/SignInScreen.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../NavigationController.dart';

class PersonalSettingController {
  XFile? mediaFile = null;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contactno = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();
  TextEditingController maritalStatus = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController emergencycontact = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController DOB = TextEditingController();
  late String profileImage;

  Future<void> submit(BuildContext context) async {
    var loader = ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    print(user_id);
    Map<String, String> bodyParam = {
      'token': Token,
      'user_id': user_id.toString(),
      'first_name': firstname.text,
      'last_name': lastname.text,
      'email': email.text,
      'mobile_no': contactno.text,
      'gender': gender.text,
      'dob': DOB.text,
      'blood_group': bloodGroup.text,
      'marital_status': maritalStatus.text,
      'height': height.text,
      'weight': weight.text,
      'emergency_contact': emergencycontact.text,
      'address': address.text,
    };

    var response = (mediaFile == null)
        ? await PostData(
            PARAM_URL: 'update_patient_details.php', params: bodyParam)
        : await PostDataWithImage(
            PARAM_URL: 'update_patient_details.php',
            params: bodyParam,
            imagePath: mediaFile!.path,
            imageparamName: 'image');

    loader.dismiss();
    if (response['status']) {
      success(context, response);
    } else {
      failure(context, response);
    }
  }

  Future<GetPatientProfile> getdata(BuildContext context) async {
    // var loader = ProgressView(context);
    // loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    print(user_id);
    var response =
        await PostData(PARAM_URL: 'get_patient_profile.php', params: {
      'token': Token,
      'user_id': user_id.toString(),
    });
    print('-=========>>>>>' + response.toString());
    // loader.dismiss();
    return GetPatientProfile.fromJson(response);
  }
}