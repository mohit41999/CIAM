import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:patient/controller/NavigationController.dart';

class doctorProfileRow extends StatelessWidget {
  const doctorProfileRow({
    Key? key,
    required this.title,
    required this.value,
    this.yellow = false,
  }) : super(key: key);
  final String title;
  final String value;
  final bool yellow;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4.7,
          child: Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: 12, color: Color(0xff161616).withOpacity(0.6)),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Text('-'),
        SizedBox(
          width: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.65,
          child: Text(
            value,
            style: GoogleFonts.montserrat(
                fontSize: 12,
                color: (yellow) ? Color(0xffD68100) : Color(0xff161616),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
