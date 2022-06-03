import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/MyModels/my_appointment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppointmentController {
  Future<MyAppointmentsModel> getCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: ApiEndPoints.completed_appointments,
        params: {'token': Token, 'user_id': prefs.getString('user_id')});
    return MyAppointmentsModel.fromJson(response);
  }

  Future<MyAppointmentsModel> getUpcoming() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: ApiEndPoints.upcoming_appointments,
        params: {'token': Token, 'user_id': prefs.getString('user_id')});
    return MyAppointmentsModel.fromJson(response);
  }
}
