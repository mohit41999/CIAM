import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/alertTextField.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/widgets/title_enter_field.dart';

void patientpg4alertbox(
    BuildContext context, TextEditingController _controller) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          backgroundColor: Color(0xffF1F1F1),
          elevation: 0,
          insetPadding: EdgeInsets.all(15),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Find In-Home Care Near You',
                    style: GoogleFonts.montserrat(
                        color: appblueColor, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close)),
                ],
              ),
              Divider(color: Colors.grey),
            ],
          ),
          content: Container(
            height: 400,
            color: Color(0xffF1F1F1),
            //padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                alertTextField(
                    controller: _controller,
                    label: 'Where is care needed?',
                    textFieldtext: 'Enter Postal Code'),
                alertTextField(
                    controller: _controller,
                    label: 'Name',
                    textFieldtext: 'Enter Full Name'),
                alertTextField(
                    controller: _controller,
                    label: 'Email',
                    textFieldtext: 'Enter Email Id'),
                alertTextField(
                    controller: _controller,
                    label: 'Phone Number',
                    textFieldtext: 'Enter Phone Number'),
                Center(
                  child: commonBtn(
                    s: 'Find Care',
                    bgcolor: Color(0xff161616).withOpacity(0.6),
                    textColor: Colors.white,
                    onPressed: () {},
                    height: 30,
                    width: 115,
                    borderRadius: 4,
                    textSize: 12,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )));
}
