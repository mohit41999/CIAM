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
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController query = TextEditingController();

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
            TitleEnterField('Name', 'Name', name),
            TitleEnterField('Email id', 'Email id', email),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Number',
                      style: TextStyle(
                          fontSize: 14, color: Colors.black.withOpacity(0.6))),
                  SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 10, maxHeight: 150),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 10,

                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: validator,
                          // maxLength: maxLength,
                          // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                          keyboardType: TextInputType.number,
                          controller: contactNo,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabled: true,
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            // enabledBorder: InputBorder.none,
                            // errorBorder: InputBorder.none,
                            // disabledBorder: InputBorder.none,
                            filled: true,

                            //labelText: labelText,
                            suffixIcon: const SizedBox(),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.6)),
                            hintText: 'Contact Number',
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.grey),
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15)
                ],
              ),
            ),
            TitleEnterField(
              'What is your query?',
              'Query',
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
