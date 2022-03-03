import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Future Push(BuildContext context, dynamic value, {bool withnav = true}) async {
  pushNewScreen(
    context,
    screen: value,
    withNavBar: withnav, // OPTIONAL VALUE. True by default.
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
  );
  // Navigator.push(context, MaterialPageRoute(builder: (context) => value));
}

Future Pop(BuildContext context) async {
  Navigator.pop(context);
}

Future PushReplacement(BuildContext context, dynamic value) async {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => value));
}
