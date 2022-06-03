import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/patient_medical_model.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicalSettingController {
  TextEditingController details_of_allergies = TextEditingController();
  TextEditingController current_and_past_medication = TextEditingController();
  TextEditingController past_surgery_injury = TextEditingController();
  TextEditingController chronic_disease = TextEditingController();

  Future<void> submit(BuildContext context) async {
    var loader = ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    print(user_id);
    var response =
        await PostData(PARAM_URL: ApiEndPoints.update_patient_medical, params: {
      'token': Token,
      'user_id': user_id.toString(),
      'details_of_allergies': details_of_allergies.text,
      'current_and_past_medication': current_and_past_medication.text,
      'past_surgery_injury': past_surgery_injury.text,
      'chronic_disease': chronic_disease.text,
    });
    print('-=========>>>>>' + response.toString());
    loader.dismiss();
    if (response['status']) {
      success(context, response);
    } else {
      failure(context, response);
    }
  }

  void initialize(BuildContext context) {
    getdata(context).then((Profile) {
      details_of_allergies.text = Profile.data.detailsOfAllergies;
      chronic_disease.text = Profile.data.chronicDisease;
      past_surgery_injury.text = Profile.data.pastSurgeryInjury;
      current_and_past_medication.text = Profile.data.currentAndPastMedication;
    });
  }

  Future<GetPatientMedical> getdata(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    print(user_id);
    var response =
        await PostData(PARAM_URL: ApiEndPoints.get_patient_medical, params: {
      'token': Token,
      'user_id': user_id.toString(),
    });
    print('-=========>>>>>' + response.toString());
    // loader.dismiss();
    return GetPatientMedical.fromJson(response);
  }
}
