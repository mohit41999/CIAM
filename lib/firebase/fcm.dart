import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseSetup {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late String fcm_token;
  Future storefcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    messaging.getToken().then((value) {
      fcm_token = value!;
      print(fcm_token);
      if (prefs.getString('user_id') == null) {
      } else {
        PostData(PARAM_URL: 'add_fcm_token.php', params: {
          'token': Token,
          'user_id': prefs.getString('user_id'),
          'fcm_token': value
        });
      }
    });
  }
}
