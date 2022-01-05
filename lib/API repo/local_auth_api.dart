import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate(BuildContext context) async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        androidAuthStrings: AndroidAuthMessages(
          signInTitle: 'Scan you Finger',
        ),
        localizedReason: 'Scan Finger to Authenticate',
        useErrorDialogs: false,
        stickyAuth: false,
        // biometricOnly: true,
      );
    } on PlatformException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title:
                    Text('Enable Pin or Fingerprint in your Device Settings'),
              ));
      return false;
    }
  }
}
