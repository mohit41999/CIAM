import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/doctor_profile_model.dart';
import 'package:patient/Models/doctor_profile_one_model.dart';
import 'package:patient/Models/slot_time_model.dart';
import 'package:patient/Screens/booking_appointment.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationController.dart';

class DoctorProfileOneController {
  late Map<String, dynamic> doctordetails;
  late Map<String, dynamic> slot_time;
  bool loading = true;

  Future<DoctorProfileOneModel> getDoctorDetails(
      BuildContext context, String doctor_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await PostData(PARAM_URL: 'doctor_profile_1.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'doctor_id': doctor_id
    }).then((value) {
      doctordetails = value;
    });
    return DoctorProfileOneModel.fromJson(doctordetails);
  }

  Future<SlotTime> getSlotTime(
      BuildContext context, String doctor_id, String date) async {
    var loader = ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    slot_time = await PostData(PARAM_URL: 'time_slot.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'doctor_id': doctor_id,
      'date': date,
    });
    loader.dismiss();

    return SlotTime.fromJson(slot_time);
  }

  Future add_booking_request(BuildContext context, String doctor_id,
      String date, String slot_time) async {
    var loader = await ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: 'add_booking_appointment.php', params: {
      'token': Token,
      'patient_id': prefs.getString('user_id'),
      'doctor_id': doctor_id,
      'booking_date': date,
      'slot_time': slot_time,
    });
    loader.dismiss();
    if (response['status']) {
      PushReplacement(
          context,
          BookingAppointment(
            booking_id: response['data']['bookingID'],
            doctor_id: response['data']['doctor_id'],
          ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
    }

    return response;
  }
}
