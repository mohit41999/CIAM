import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:patient/controller/NavigationController.dart';

class rowTextIcon extends StatelessWidget {
  final String asset;
  final String text;
  const rowTextIcon({
    Key? key,
    required this.asset,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          asset,
          height: 14,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          text,
          style: GoogleFonts.montserrat(fontSize: 12),
        ),
      ],
    );
  }
}
