import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/my_lab_packages_model.dart';
import 'package:patient/Models/LAB/my_lab_test_model.dart';
import 'package:patient/Models/confirm_booking_model.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/my_health_care_model.dart';
import 'package:patient/Models/my_hospital_package_model.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentController {
  Future<MyLabTestBooking> getlabTestBooking(BuildContext context) async {
    // var loader = ProgressView(context);
    // loader.show();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: AppEndPoints.my_lab_test_bookings, params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
    });
    // loader.dismiss();
    return MyLabTestBooking.fromJson(response);
  }

  Future<MyLabPackageBooking> getlabPackageBooking(BuildContext context) async {
    // var loader = ProgressView(context);
    // loader.show();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.my_lab_package_bookings,
        params: {
          'token': Token,
          'user_id': prefs.getString('user_id'),
        });
    // loader.dismiss();
    return MyLabPackageBooking.fromJson(response);
  }

  Future<MyHospitalPackageModel> getHospitalPackageBooking(
      BuildContext context) async {
    // var loader = ProgressView(context);
    // loader.show();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.my_hospital_package_bookings,
        params: {
          'token': Token,
          'user_id': prefs.getString('user_id'),
        });
    // loader.dismiss();
    return MyHospitalPackageModel.fromJson(response);
  }

  Future<MyHealthCareModel> getHealthCareBooking(BuildContext context) async {
    // var loader = ProgressView(context);
    // loader.show();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: AppEndPoints.my_home_care_bookings, params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
    });
    // loader.dismiss();
    return MyHealthCareModel.fromJson(response);
  }
}
