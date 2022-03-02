import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient/Screens/PaymentScreens/payment_confirmation_screen.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/DoctorProdileController/confirm_booking_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions(
      {Key? key, required this.amount, required this.booking_id})
      : super(key: key);
  final String amount;
  final String booking_id;

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'Terms And Conditions'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Terms and Conditions'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: commonBtn(
                  s: 'Proceed',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentConfirmationScreen(
                                  amount: widget.amount,
                                  booking_id: widget.booking_id,
                                )));
                    // _con
                    //     .confirmBookingRequest(
                    //         context, widget.booking_id)
                    //     .then((value) {
                    //   _con
                    //       .getconfirmBooking(context,
                    //           widget.doctor_id, widget.booking_id)
                    //       .then((value) {
                    //     setState(() {
                    //       confirmData = value;
                    //     });
                    //   });
                    // });
                  },
                  borderRadius: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
