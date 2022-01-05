import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/patient_lifeStyle_model.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifestyleSettingController {
  var SmokingList = ['Yes', 'No'];
  var AlcoholList = ['Yes', 'No'];
  var WorkOutLevelList = ['Low', 'Medium', 'High'];
  var SportsInvolvementList = ['Low', 'Medium', 'High'];

  late String SmokingdropdownValue;
  late String AlcoholdropdownValue;
  late String WorkOutLeveldropdownValue;
  late String SportsInvolvementdropdownValue;
  bool loading = true;

  Future<void> submit(BuildContext context) async {
    var loader = ProgressView(context);
    loader.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    print(user_id);
    var response =
        await PostData(PARAM_URL: 'update_patient_lifestyle.php', params: {
      'token': Token,
      'user_id': user_id.toString(),
      'smoking': SmokingdropdownValue.toString(),
      'alchol': AlcoholdropdownValue.toString(),
      'workout_level': WorkOutLeveldropdownValue.toString(),
      'sports_involvement': SportsInvolvementdropdownValue.toString(),
    });
    loader.dismiss();
    compareresponsedata(response, context);
    // if (response['status']) {
    //   success(context, response);
    // } else {
    //   failure(context, response);
    // }

    // print(response.toString() + '===============>');
  }

  Future initialize(BuildContext context) async {
    await getdata(context).then((Profile) {
      SmokingdropdownValue = Profile.data.smoking.toString();
      AlcoholdropdownValue = Profile.data.alchol.toString();
      WorkOutLeveldropdownValue = Profile.data.workoutLevel.toString();
      SportsInvolvementdropdownValue =
          Profile.data.sportsInvolvement.toString();
    });
  }

  Future<GetPatientLifeStyle> getdata(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    print(user_id);
    var response =
        await PostData(PARAM_URL: 'get_patient_lifestyle.php', params: {
      'token': Token,
      'user_id': user_id.toString(),
    });
    print('-=========>>>>>' + response.toString());
    // loader.dismiss();
    return GetPatientLifeStyle.fromJson(response);
  }
}
