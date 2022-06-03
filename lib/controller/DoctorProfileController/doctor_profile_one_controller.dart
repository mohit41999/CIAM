import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/doc_review_model.dart';
import 'package:patient/Models/doctor_profile_one_model.dart';
import 'package:patient/Models/slot_time_model.dart';
import 'package:patient/Screens/booking_appointment.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationController.dart';

class DoctorProfileOneController {
  late Map<String, dynamic> doctordetails;
  late Map<String, dynamic> slot_time;
  String bookingFor = '0';
  bool loading = true;
  PlatformFile? file = null;

  Future<DoctorProfileOneModel> getDoctorDetails(
      BuildContext context, String doctor_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await PostData(PARAM_URL: ApiEndPoints.doctor_profile_1, params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'doctor_id': doctor_id
    }).then((value) {
      doctordetails = value;
    });
    return DoctorProfileOneModel.fromJson(doctordetails);
  }

  Future<DocReviewModel> getRatingsandReview(
      BuildContext context, String doctor_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: ApiEndPoints.get_doctor_review,
        params: {
          'token': Token,
          'user_id': prefs.getString('user_id'),
          'doctor_id': doctor_id
        });
    return DocReviewModel.fromJson(response);
  }

  Future<SlotTime> getSlotTime(
      BuildContext context, String doctor_id, String date) async {
    var loader = ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    slot_time = await PostData(PARAM_URL: ApiEndPoints.time_slot, params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'doctor_id': doctor_id,
      'date': date,
    });
    loader.dismiss();

    return SlotTime.fromJson(slot_time);
  }

  Future add_booking_request(BuildContext context,
      {required String doctor_id,
      required String date,
      required String slot_time,
      required String fees}) async {
    var loader = await ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> bodyParams = {
      'token': Token,
      'patient_id': prefs.getString('user_id')!,
      'doctor_id': doctor_id,
      'booking_date': date,
      'slot_time': slot_time,
      'fees': fees,
      'booking_for': bookingFor
    };

    var response = await PostData(
        PARAM_URL: ApiEndPoints.add_booking_appointment, params: bodyParams);
    loader.dismiss();
    if (response['status']) {
      Push(
          context,
          BookingAppointment(
            booking_id: response['data']['bookingID'],
            doctor_id: response['data']['doctor_id'],
          ),
          withnav: false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
    }

    return response;
  }
}
