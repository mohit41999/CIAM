import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';

class commonAppBarLeading extends StatefulWidget {
  final IconData iconData;
  final GestureTapCallback onPressed;

  const commonAppBarLeading({
    Key? key,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  @override
  _commonAppBarLeadingState createState() => _commonAppBarLeadingState();
}

class _commonAppBarLeadingState extends State<commonAppBarLeading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          child: Container(
            width: 40,
            height: 40,
            child: Center(
              child: Icon(
                widget.iconData,
                color: appblueColor,
                size: 20,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(2, 5),
                ),
              ],
            ),
          ),
          onTap: widget.onPressed),
    );
  }
}
