import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/doctor_profile_model.dart';
import 'package:patient/Models/medicine_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API repo/api_end_points.dart';

class MedicineProfileController {
  late Map<String, dynamic> medicines;

  Future<MedicineProfileModel> getMedicines(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await PostData(
            PARAM_URL: AppEndPoints.get_medicines_list,
            params: {'token': Token, 'user_id': prefs.getString('user_id')})
        .then((value) {
      medicines = value;
    });
    return MedicineProfileModel.fromJson(medicines);
  }
}
