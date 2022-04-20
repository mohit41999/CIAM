import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';

class TagLine extends StatelessWidget {
  const TagLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Making ',
                style: TextStyle(
                    color: apptealColor.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
              Text(
                'HealthCare\nUnderstandable ',
                style: TextStyle(
                    color: appblueColor.withOpacity(0.8),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: apptealColor)],
                    letterSpacing: 1),
              ),
            ],
          )),
    );
  }
}
