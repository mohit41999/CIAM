import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/askQuestionCategoryModel.dart';
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
  AskQuestionCategoryModel? askCategroies;
  var selectedCategroy;
  Future<AskQuestionCategoryModel?> getAskQuestioncategories() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var response = await PostData(
          PARAM_URL: 'get_ask_question_category.php',
          params: {
            'token': Token,
            'user_id': preferences.getString('user_id')
          });
      return AskQuestionCategoryModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future submitQuestion() async {
    if (selectedCategroy == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select Category'),
        backgroundColor: Colors.red,
      ));
    } else if (query.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Query Required'),
        backgroundColor: Colors.red,
      ));
    } else if (querydescription.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Query Description Required'),
        backgroundColor: Colors.red,
      ));
    } else {
      var loader = ProgressView(context);
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        loader.show();

        var response = await PostData(PARAM_URL: 'ask_question.php', params: {
          'token': Token,
          'category_id': selectedCategroy.toString(),
          'user_id': preferences.getString('user_id'),
          'question': query.text,
          'description': querydescription.text
        });
        loader.dismiss();
        if (response['status']) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Query has been submitted'),
            backgroundColor: apptealColor,
          ));
          Pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Try again later'),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong.... try again later'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  bool catload = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAskQuestioncategories().then((value) {
      setState(() {
        askCategroies = value!;
        catload = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonAppBarTitle(),
        titleSpacing: 0,
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
        centerTitle: false,
        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
      body: (askCategroies == null && catload == false)
          ? Center(child: Text('Please try again later'))
          : Padding(
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
                  (catload)
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              child: Align(
                                child: Text(
                                  'Category',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: Material(
                                elevation: 5,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  width: double.infinity,
                                  child: DropdownButton(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    underline: Container(),
                                    dropdownColor: Colors.white,

                                    isExpanded: true,

                                    // Initial Value
                                    hint: Text(
                                      'Category',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: askCategroies!.data.map(
                                        (AskQuestionCategoryModelData items) {
                                      return DropdownMenuItem(
                                        value: items.categoryId,
                                        child: Text(items.categoryName),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (newValue) {
                                      setState(() {
                                        print(newValue);
                                        selectedCategroy = newValue.toString();
                                      });
                                    },
                                    value: selectedCategroy,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  TitleEnterField('Query', 'Query', query),
                  TitleEnterField(
                    'Query Description',
                    'Query Description',
                    querydescription,
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
                        setState(() {
                          submitQuestion();
                        });
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
