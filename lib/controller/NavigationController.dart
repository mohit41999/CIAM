import 'package:flutter/material.dart';

Future Push(BuildContext context, dynamic value) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => value));
}

Future Pop(BuildContext context) async {
  Navigator.pop(context);
}

Future PushReplacement(BuildContext context, dynamic value) async {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => value));
}
