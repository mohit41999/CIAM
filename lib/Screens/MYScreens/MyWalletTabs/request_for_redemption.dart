import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_enter_field.dart';

class RequestForRedemption extends StatefulWidget {
  const RequestForRedemption({Key? key}) : super(key: key);

  @override
  _RequestForRedemptionState createState() => _RequestForRedemptionState();
}

class _RequestForRedemptionState extends State<RequestForRedemption> {
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleEnterField('Enter Amount', 'Amount', amount),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: navbarht + 20),
              child: commonBtn(
                s: 'Submit  ',
                bgcolor: appblueColor,
                textColor: Colors.white,
                onPressed: () {},
                borderRadius: 8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
