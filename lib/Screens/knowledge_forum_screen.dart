import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Screens/MYScreens/MyReviewRating.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/tag_line.dart';

class KnowledgeForumScreen extends StatefulWidget {
  const KnowledgeForumScreen({Key? key}) : super(key: key);

  @override
  _KnowledgeForumScreenState createState() => _KnowledgeForumScreenState();
}

class _KnowledgeForumScreenState extends State<KnowledgeForumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: commonAppBarTitleText(appbarText: 'Knowledge Forum'),
          backgroundColor: appAppBarColor,
          elevation: 0,
          leading: Builder(
              builder: (context) => commonAppBarLeading(
                  iconData: Icons.arrow_back_ios_new,
                  onPressed: () {
                    Navigator.pop(context);
                  })),
        ),
        body: ListView(
          children: [
            ListView.builder(
                itemCount: 5,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 4.0, right: 4.0, top: 4.0, bottom: 4),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'DoctorName',
                                        style: GoogleFonts.lato(
                                            color: Color(0xff252525),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '  27/09/2021',
                                        style: GoogleFonts.lato(
                                            color: apptealColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea.',
                                    style: GoogleFonts.lato(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: 10,
            ),
            TagLine(),
            SizedBox(
              height: navbarht + 20,
            ),
          ],
        ));
  }
}
