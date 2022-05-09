import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';

class UploadPrescriptionScreen extends StatefulWidget {
  const UploadPrescriptionScreen({Key? key}) : super(key: key);

  @override
  _UploadPrescriptionScreenState createState() =>
      _UploadPrescriptionScreenState();
}

class _UploadPrescriptionScreenState extends State<UploadPrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Have a Prescription ? Upload Here',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 75,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.photo_camera_outlined,
                                color: appblueColor,
                              ),
                              Text(
                                'Camera',
                                style:
                                    GoogleFonts.montserrat(color: appblueColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 75,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.folder_outlined,
                                color: appblueColor,
                              ),
                              Text(
                                'File Explorer',
                                style:
                                    GoogleFonts.montserrat(color: appblueColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 75,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'View My Prescription',
                              textAlign: TextAlign.center,
                              style:
                                  GoogleFonts.montserrat(color: appblueColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.security_outlined,
                            color: apptealColor,
                            size: 40,
                          )
                        ],
                      ),
                      title: Text(
                        'Your attached prescription will be secure and private',
                        style: GoogleFonts.montserrat(
                            color: apptealColor, fontSize: 14),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outlined,
                            color: apptealColor,
                            size: 20,
                          )
                        ],
                      ),
                      title: Text(
                        'Valid prescription Guide',
                        style: GoogleFonts.montserrat(
                            color: apptealColor, fontSize: 14),
                      ),
                    ),
                    Text(
                      'Why Upload a prescription?',
                      style: GoogleFonts.montserrat(
                          color: apptealColor, fontSize: 14),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et.',
                      style: GoogleFonts.montserrat(
                          color: apptealColor, fontSize: 14),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consetetur',
                      style: GoogleFonts.montserrat(
                          color: apptealColor, fontSize: 14),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consetetur',
                      style: GoogleFonts.montserrat(
                          color: apptealColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: navbarht + 20),
              child: commonBtn(
                s: 'Continue',
                bgcolor: appblueColor,
                textColor: Colors.white,
                onPressed: () {},
                borderRadius: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
