import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController ifscCode = TextEditingController();
TextEditingController accountNo = TextEditingController();
TextEditingController amount = TextEditingController();
TextEditingController holderName = TextEditingController();

class CancelController {
  Future cancelDoctorBooking(BuildContext context, String bookingId) async {
    var loader = ProgressView(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print('doctor');
    print(bookingId);
    print(preferences.getString('user_id'));
    print(Token);
    print(ifscCode.text);
    print(amount.text);
    print(accountNo.text);
    print(holderName.text);
    loader.show();
    try {
      var response = await PostData(
          PARAM_URL: ApiEndPoints.cancel_doctor_consultation,
          params: {
            'token': Token,
            'user_id': preferences.getString('user_id'),
            'ifsc_code': ifscCode.text,
            'account_no': accountNo.text,
            'amount': amount.text,
            'holder_name': holderName.text,
            'booking_id': bookingId
          });
      loader.dismiss();
      if (response['status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cancellation Successful'),
          backgroundColor: apptealColor,
        ));
        Pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error'),
          backgroundColor: apptealColor,
        ));
      }
    } catch (e) {
      loader.dismiss();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error ... Try again later'),
        backgroundColor: apptealColor,
      ));
    }
  }

  Future cancelLabPackage(BuildContext context, String bookingId) async {
    var loader = ProgressView(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    loader.show();
    try {
      var response =
          await PostData(PARAM_URL: ApiEndPoints.cancel_lab_package, params: {
        'token': Token,
        'user_id': preferences.getString('user_id'),
        'ifsc_code': ifscCode.text,
        'account_no': accountNo.text,
        'amount': amount.text,
        'holder_name': holderName.text,
        'booking_id': bookingId
      });
      loader.dismiss();
      if (response['status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cancellation Successful'),
          backgroundColor: apptealColor,
        ));
        Pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error'),
          backgroundColor: apptealColor,
        ));
      }
    } catch (e) {
      loader.dismiss();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error... Try again later'),
        backgroundColor: apptealColor,
      ));
    }
  }

  Future cancelLabTest(BuildContext context, String bookingId) async {
    var loader = ProgressView(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    loader.show();
    try {
      var response =
          await PostData(PARAM_URL: ApiEndPoints.cancel_lab_test, params: {
        'token': Token,
        'user_id': preferences.getString('user_id'),
        'ifsc_code': ifscCode.text,
        'account_no': accountNo.text,
        'amount': amount.text,
        'holder_name': holderName.text,
        'booking_id': bookingId
      });
      loader.dismiss();
      if (response['status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cancellation Successful'),
          backgroundColor: apptealColor,
        ));
        Pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error... Try again later'),
          backgroundColor: apptealColor,
        ));
      }
    } catch (e) {
      loader.dismiss();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error'),
        backgroundColor: apptealColor,
      ));
    }
  }
}
