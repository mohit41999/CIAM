import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/account_setting.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_enter_field.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  AccountSettingController _con = AccountSettingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'Account Setting'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              TitleEnterField(
                  'Enter Old Password', 'Change Password', _con.old_password),
              TitleEnterField(
                  'Enter New Password', 'New Password', _con.new_password),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Deactivate Account',
                    style: GoogleFonts.montserrat(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: commonBtn(
                s: 'Submit  ',
                bgcolor: appblueColor,
                textColor: Colors.white,
                onPressed: () {
                  _con.changesPassword(context);
                },
                borderRadius: 8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
