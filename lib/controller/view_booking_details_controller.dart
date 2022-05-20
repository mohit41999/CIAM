import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/view_booking_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewBookingDetailsController {
  Future<ViewBookingDetailsModel?> getViewDetails(
      String booking_id, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await PostData(
        PARAM_URL: AppEndPoints.get_view_booking_details,
        params: {
          'token': Token,
          'user_id': prefs.getString('user_id'),
          'booking_id': booking_id,
        });

    if (response['status']) {
      return ViewBookingDetailsModel.fromJson(response);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data not Found')));
    }
  }
}
