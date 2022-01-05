import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Utils/colorsandstyles.dart';

import 'package:patient/controller/NavigationController.dart';

class commonAppBarTitle extends StatelessWidget {
  const commonAppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(colors: [
          Color(0xff233E8B),
          Color(0xff1EAE98),
        ]).createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Text(
          'DCP',
          style: GoogleFonts.montserrat(
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}

class commonAppBarTitleText extends StatelessWidget {
  const commonAppBarTitleText({
    Key? key,
    required this.appbarText,
  }) : super(key: key);
  final String appbarText;
  @override
  Widget build(BuildContext context) {
    return Text(
      appbarText,
      style: GoogleFonts.montserrat(
          fontSize: 20, color: apptealColor, fontWeight: FontWeight.bold),
    );
  }
}
