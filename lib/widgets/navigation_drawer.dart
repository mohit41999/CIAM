import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/Screens/MYScreens/MyAppointments.dart';
import 'package:patient/Screens/MYScreens/MyLabTest.dart';
import 'package:patient/Screens/MYScreens/MyMedicineOrders.dart';
import 'package:patient/Screens/MYScreens/MyOrderPage.dart';
import 'package:patient/Screens/MYScreens/MyPrescriprions.dart';
import 'package:patient/Screens/MYScreens/MyQuestionsScreen.dart';
import 'package:patient/Screens/MYScreens/MyReviewRating.dart';
import 'package:patient/Screens/MYScreens/MyWalletTabs/my_wallet_pg.dart';
import 'package:patient/Screens/ProfileSettings/profile_setting.dart';
import 'package:patient/Screens/SignInScreen.dart';
import 'package:patient/Screens/account_settings.dart';
import 'package:patient/Utils/drawerList.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/firebase/AuthenticatioHelper.dart';

import '../Utils/colorsandstyles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'commonAppBarLeading.dart';

class commonDrawer extends StatefulWidget {
  const commonDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<commonDrawer> createState() => _commonDrawerState();
}

class _commonDrawerState extends State<commonDrawer> {
  Future<void> _ackAlert(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout!'),
          content: const Text('Are you sure want to logout'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                AuthenticationHelper().signOut();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                preferences.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xffF1F1F1),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/pngs/Rectangle 51.png'),
                          fit: BoxFit.cover)),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: drawerList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Text(
                                  drawerList[index]['label'],
                                  style: GoogleFonts.montserrat(
                                      color: apptealColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  (drawerList[index]['label'].toString() ==
                                          'Logout')
                                      ? _ackAlert(context)
                                      : Push(
                                          context, drawerList[index]['Screen']);
                                },
                              ),
                              (index == drawerList.length - 1)
                                  ? SizedBox(
                                      height: 100,
                                    )
                                  : Container()
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 8),
                  child: commonAppBarLeading(
                      iconData: Icons.arrow_back_ios_new,
                      onPressed: () {
                        Navigator.pop(context);
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
