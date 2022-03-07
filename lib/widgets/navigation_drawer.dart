import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/Screens/SignInScreen.dart';
import 'package:patient/Screens/account_settings.dart';
import 'package:patient/Utils/drawerList.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/ProfileSettingController/personal_setting_controller.dart';
import 'package:patient/firebase/AuthenticatioHelper.dart';

import '../Utils/colorsandstyles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'commonAppBarLeading.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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

  late String profilepic;
  bool loading = true;
  Future initialize() async {
    PersonalSettingController().getdata(context).then((value) {
      setState(() {
        profilepic = value.data.profile;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
    print('hello');
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
                (loading)
                    ? Container(
                        height: 250,
                        child: Center(child: CircularProgressIndicator()))
                    : Container(
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(profilepic),
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
                                  if (drawerList[index]['label'].toString() ==
                                      'Logout') {
                                    _ackAlert(context);
                                  } else {
                                    Navigator.pop(context);
                                    pushNewScreen(
                                      context,
                                      screen: drawerList[index]['Screen'],
                                      withNavBar:
                                          true, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                    // Push(context, drawerList[index]['Screen']);
                                  }
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
