import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/ask_question_model.dart';
import 'package:patient/Models/search_ask_question_model.dart';
import 'package:patient/Screens/ask_questions_screen.dart';
import 'package:patient/Screens/give_answer_answer.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyQuestionsScreen extends StatefulWidget {
  const MyQuestionsScreen({Key? key}) : super(key: key);

  @override
  _MyQuestionsScreenState createState() => _MyQuestionsScreenState();
}

class _MyQuestionsScreenState extends State<MyQuestionsScreen> {
  late AskQuestionModel myquestions;
  late SearchAskQuestionModel searchQuestionData;
  TextEditingController searchController = TextEditingController();
  Future<AskQuestionModel> getQuestions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response = await PostData(
        PARAM_URL: 'get_patient_question_list.php',
        params: {'token': Token, 'user_id': preferences.getString('user_id')});
    return AskQuestionModel.fromJson(response);
  }

  Future<SearchAskQuestionModel> searchQuestion() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response = await PostData(
        PARAM_URL: 'search_ask_question.php',
        params: {'token': Token, 'user_id': preferences.getString('user_id')});
    return SearchAskQuestionModel.fromJson(response);
  }

  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestions().then((value) {
      setState(() {
        myquestions = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: AppBar(
          centerTitle: false,
          title: commonAppBarTitleText(appbarText: 'My Questions'),
          backgroundColor: appAppBarColor,
          elevation: 0,
          titleSpacing: 0,
          leading: Builder(
              builder: (context) => commonAppBarLeading(
                  iconData: Icons.arrow_back_ios_new,
                  onPressed: () {
                    Navigator.pop(context);
                  })),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            minHeight: 10,
                            maxHeight: 60,
                            maxWidth: double.maxFinite),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(2, 5),
                              ),
                            ],
                          ),
                          child: TextField(
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: validator,
                            // maxLength: maxLength,
                            // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                            enableSuggestions: true,
                            controller: searchController,
                            onChanged: (v) {
                              setState(() {});
                            },

                            decoration: InputDecoration(
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: new BorderSide(
                                        color: Colors.transparent)),
                                border: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: new BorderSide(
                                        color: Colors.transparent)),
                                // enabledBorder: InputBorder.none,
                                // errorBorder: InputBorder.none,
                                // disabledBorder: InputBorder.none,
                                filled: true,
                                labelStyle: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.6)),
                                hintStyle: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.6)),
                                fillColor: Colors.white,
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: commonBtn(
                          s: 'Ask Question',
                          bgcolor: appblueColor,
                          textColor: Colors.white,
                          borderRadius: 5,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AskQuestionsScreen())).then((value) {
                              getQuestions().then((value) {
                                setState(() {
                                  myquestions = value;
                                });
                              });
                            });
                          }),
                    ),
                    (loading)
                        ? Expanded(
                            child: Center(child: CircularProgressIndicator()))
                        : (myquestions.data.length == 0)
                            ? Expanded(
                                child: Text('No questions asked till now'))
                            : Expanded(
                                child: ListView(
                                  children: [
                                    Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: myquestions.data.length,
                                            itemBuilder: (context, index) {
                                              return (searchController
                                                      .text.isEmpty)
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 4.0,
                                                          right: 4.0,
                                                          top: 4.0,
                                                          bottom: 4),
                                                      child: Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                GiveAnswerScreen(question_id: myquestions.data[index].questionId)));
                                                              }
                                                            },
                                                            child: Card(
                                                              elevation: 3,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          myquestions
                                                                              .data[index]
                                                                              .question,
                                                                          style: GoogleFonts.lato(
                                                                              color: Color(0xff252525),
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          '  ${myquestions.data[index].createdDate.day}/${myquestions.data[index].createdDate.month}/${myquestions.data[index].createdDate.year}',
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
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Category:-',
                                                                          style: GoogleFonts.lato(
                                                                              color: Color(0xff252525),
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          myquestions
                                                                              .data[index]
                                                                              .category_name
                                                                              .toString(),
                                                                          style: GoogleFonts.lato(
                                                                              color: Color(0xff252525),
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 8,
                                                                    ),
                                                                    Text(
                                                                      myquestions
                                                                          .data[
                                                                              index]
                                                                          .description,
                                                                      style: GoogleFonts.lato(
                                                                          fontSize:
                                                                              12),
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
                                                    )
                                                  : (myquestions.data[index]
                                                              .question
                                                              .toLowerCase()
                                                              .replaceAll(
                                                                  ' ', '')
                                                              .contains(searchController
                                                                  .text
                                                                  .toLowerCase()
                                                                  .replaceAll(
                                                                      ' ',
                                                                      '')) ||
                                                          myquestions
                                                              .data[index]
                                                              .description
                                                              .toLowerCase()
                                                              .replaceAll(
                                                                  ' ', '')
                                                              .contains(searchController
                                                                  .text
                                                                  .toLowerCase()
                                                                  .replaceAll(
                                                                      ' ', '')))
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4.0,
                                                                  right: 4.0,
                                                                  top: 4.0,
                                                                  bottom: 4),
                                                          child: Column(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                GiveAnswerScreen(question_id: myquestions.data[index].questionId)));
                                                                  }
                                                                },
                                                                child: Card(
                                                                  elevation: 3,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              myquestions.data[index].question,
                                                                              style: GoogleFonts.lato(color: Color(0xff252525), fontSize: 14, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              '  ${myquestions.data[index].createdDate.day}/${myquestions.data[index].createdDate.month}/${myquestions.data[index].createdDate.year}',
                                                                              style: GoogleFonts.lato(color: apptealColor, fontSize: 12, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              8,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'Category:-',
                                                                              style: GoogleFonts.lato(color: Color(0xff252525), fontSize: 14, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              myquestions.data[index].category_name.toString(),
                                                                              style: GoogleFonts.lato(color: Color(0xff252525), fontSize: 14, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              8,
                                                                        ),
                                                                        Text(
                                                                          myquestions
                                                                              .data[index]
                                                                              .description,
                                                                          style:
                                                                              GoogleFonts.lato(fontSize: 12),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
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
                                                        )
                                                      : Container();
                                            }),
                                        Container(
                                          color: Colors.transparent,
                                          height: navbarht + 20,
                                        ),
                                        Container(
                                          color: Colors.transparent,
                                          height: navbarht + 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
