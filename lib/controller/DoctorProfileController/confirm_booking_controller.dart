import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/confirm_booking_model.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmBookingController {
  Future<ConfirmBookingModel> getconfirmBooking(
      BuildContext context, String doctor_id, String booking_id) async {
    // var loader = ProgressView(context);
    // loader.show();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: ApiEndPoints.get_confirmation_booking_details,
        params: {
          'token': Token,
          'user_id': prefs.getString('user_id'),
          'doctor_id': doctor_id,
          'booking_id': booking_id
        });
    // loader.dismiss();
    return ConfirmBookingModel.fromJson(response);
  }

  Future confirmBookingRequest(BuildContext context, String booking_id) async {
    var loader = ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: ApiEndPoints.add_booking_confirmation,
        params: {
          'token': Token,
          'user_id': prefs.getString('user_id'),
          // 'doctor_id': doctor_id,
          'booking_id': booking_id
        });
    loader.dismiss();
    if (response['status']) {
      // success(context, response);
    } else {
      failure(context, response);
    }
  }

  Future addPaymentTransaction(BuildContext context, String booking_id,
      String amount, bool terms) async {
    var loader = ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: ApiEndPoints.add_payment_transaction,
        params: {
          'token': Token,
          'user_id': prefs.getString('user_id'),
          'booking_id': booking_id,
          'amount': amount,
          'payment_status': 'success'
        });
    loader.dismiss();
    if (response['status']) {
      Navigator.pop(context);
      Navigator.pop(context);
      (terms) ? Navigator.pop(context) : null;
    } else {
      failure(context, response);
    }
  }
}
