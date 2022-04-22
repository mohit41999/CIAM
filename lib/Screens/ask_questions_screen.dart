import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/tag_line.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskQuestionsScreen extends StatefulWidget {
  const AskQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<AskQuestionsScreen> createState() => _AskQuestionsScreenState();
}

class _AskQuestionsScreenState extends State<AskQuestionsScreen> {
  TextEditingController query = TextEditingController();
  TextEditingController querydescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonAppBarTitle(),
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Queries',
                style: GoogleFonts.montserrat(
                    color: apptealColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            TitleEnterField('Query', 'Query', query),
            TitleEnterField(
              'Query Description',
              'Query Description',
              query,
              maxLines: 10,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: commonBtn(
                s: 'Submit',
                bgcolor: appblueColor,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {});
                },
                borderRadius: 8,
                textSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TagLine(),
            SizedBox(
              height: navbarht + 20,
            ),
          ],
        ),
      ),
    );
  }
}
