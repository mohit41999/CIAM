import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_enter_field.dart';

class CancelScreen extends StatefulWidget {
  const CancelScreen({Key? key}) : super(key: key);

  @override
  State<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends State<CancelScreen> {
  TextEditingController BnameCtl = TextEditingController();
  TextEditingController AccNoCtl = TextEditingController();
  TextEditingController IFSC_CODECtl = TextEditingController();
  TextEditingController HolderNameCtl = TextEditingController();
  TextEditingController AmountCtl = TextEditingController();

  bool loading = false;
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
              TitleEnterField('Bank Name', 'Bank Name', BnameCtl),
              TitleEnterField('Account Number', 'Account Number', AccNoCtl),
              TitleEnterField('IFSC CODE', 'IFSC CODE', IFSC_CODECtl),
              TitleEnterField('Holder Name', 'Holder Name', HolderNameCtl),
              TitleEnterField(
                'Amount',
                'Amount',
                AmountCtl,
                textInputType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: commonBtn(
                  s: 'Submit',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {},
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        ));
  }
}
