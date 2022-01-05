import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/home_doctor_speciality_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  late Map<String, dynamic> doctorspeciality;
  bool specialitybool = true;

  Future<HomeDoctorSpecialityModel> getDoctorSpecilities(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await PostData(
            PARAM_URL: 'get_doctor_specialisties.php',
            params: {'token': Token, 'user_id': prefs.getString('user_id')})
        .then((value) {
      doctorspeciality = value;
    });
    return HomeDoctorSpecialityModel.fromJson(doctorspeciality);
  }
}
