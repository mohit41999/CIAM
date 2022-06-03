import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/doctor_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorController {
  late Map<String, dynamic> doctors;
  bool loading = true;
  Future<DoctorProfileModel> getDoctor(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    doctors = await PostData(
        PARAM_URL: ApiEndPoints.get_doctors,
        params: {'token': Token, 'user_id': prefs.getString('user_id')});
    return DoctorProfileModel.fromJson(doctors);
  }
}
