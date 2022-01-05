import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/my_appointment_model.dart';
import 'package:patient/Screens/MYScreens/MyAppointments.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppointmentController {
  Future<MyAppointmentsModel> getMyAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'my_appointment.php',
        params: {'token': Token, 'user_id': prefs.getString('user_id')});
    return MyAppointmentsModel.fromJson(response);
  }
}
