import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:patient/controller/NavigationController.dart';

class commonBtn extends StatelessWidget {
  final String s;
  final Color bgcolor;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double textSize;
  final FontWeight fontWeight;
  final double borderRadius;
  const commonBtn({
    Key? key,
    required this.s,
    required this.bgcolor,
    required this.textColor,
    required this.onPressed,
    this.height = 50,
    this.width = double.infinity,
    this.textSize = 16,
    this.fontWeight = FontWeight.w700,
    this.borderRadius = 16.0,
    this.borderColor = Colors.white,
    this.borderWidth = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(bgcolor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    side: BorderSide(color: borderColor, width: borderWidth)))),
        onPressed: onPressed,
        child: Text(
          s,
          style: GoogleFonts.montserrat(
              fontSize: textSize,
              color: textColor,
              letterSpacing: 1,
              fontWeight: fontWeight),
        ),
      ),
    );
  }
}
