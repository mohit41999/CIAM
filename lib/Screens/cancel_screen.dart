import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/cancel_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_enter_field.dart';

class CancelScreen extends StatefulWidget {
  final bool isDoctor;
  final String booking_id;
  final String amount;
  final bool isLabTest;
  final bool isLabPAckage;
  const CancelScreen(
      {Key? key,
      this.isDoctor = false,
      this.isLabTest = false,
      this.isLabPAckage = false,
      required this.booking_id,
      required this.amount})
      : super(key: key);

  @override
  State<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends State<CancelScreen> {
  CancelController _controller = CancelController();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    amount.text = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: commonAppBarTitleText(appbarText: 'Bank Details'),
          backgroundColor: appAppBarColor,
          elevation: 0,
          leading: commonAppBarLeading(
              iconData: Icons.arrow_back_ios,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TitleEnterField('Account Number', 'Account Number', accountNo),
              TitleEnterField('IFSC CODE', 'IFSC CODE', ifscCode),
              TitleEnterField('Holder Name', 'Holder Name', holderName),
              TitleEnterField(
                'Amount',
                'Amount',
                amount,
                readonly: true,
                textInputType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: commonBtn(
                  s: 'Submit',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {
                    (widget.isDoctor)
                        ? _controller.cancelDoctorBooking(
                            context, widget.booking_id)
                        : (widget.isLabTest)
                            ? _controller.cancelLabTest(
                                context, widget.booking_id)
                            : _controller.cancelLabPackage(
                                context, widget.booking_id);
                  },
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        ));
  }
}
