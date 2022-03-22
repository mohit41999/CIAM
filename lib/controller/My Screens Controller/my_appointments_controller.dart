import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/MyModels/my_appointment_model.dart';
import 'package:patient/Screens/MYScreens/MyAppointments.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppointmentController {
  Future<MyAppointmentsModel> getCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'completed_appointments.php',
        params: {'token': Token, 'user_id': prefs.getString('user_id')});
    return MyAppointmentsModel.fromJson(response);
  }

  Future<MyAppointmentsModel> getUpcoming() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'upcoming_appointments.php',
        params: {'token': Token, 'user_id': prefs.getString('user_id')});
    return MyAppointmentsModel.fromJson(response);
  }
}
