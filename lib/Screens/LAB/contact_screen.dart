import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';

class LabContactScreen extends StatefulWidget {
  const LabContactScreen({Key? key}) : super(key: key);

  @override
  _LabContactScreenState createState() => _LabContactScreenState();
}

class _LabContactScreenState extends State<LabContactScreen> {
  kStyle(
          {required Color kcolor,
          required double size,
          FontWeight fontWeight = FontWeight.normal}) =>
      GoogleFonts.montserrat(
          color: kcolor, fontSize: size, fontWeight: fontWeight);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Contact On',
                  style: kStyle(
                      kcolor: Colors.black,
                      size: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et.',
                  style: kStyle(
                    kcolor: Colors.black,
                    size: 14,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: Color(0xff409690),
                    ),
                    Text(' +91 79840 96987',
                        style: kStyle(
                            kcolor: Colors.black,
                            size: 14,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: Color(0xff409690),
                    ),
                    Text(' +91 79840 96987',
                        style: kStyle(
                            kcolor: Colors.black,
                            size: 14,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
