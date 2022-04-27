import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/question_description_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiveAnswerScreen extends StatefulWidget {
  final String question_id;
  const GiveAnswerScreen({Key? key, required this.question_id})
      : super(key: key);

  @override
  _GiveAnswerScreenState createState() => _GiveAnswerScreenState();
}

class _GiveAnswerScreenState extends State<GiveAnswerScreen> {
  TextEditingController answerController = TextEditingController();
  late QuestionDescriptionAnswerModel questionsDescriptions;
  Future<QuestionDescriptionAnswerModel> getQuestionsDescription() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: 'get_question_answers.php', params: {
      'token': Token,
      'user_id': preferences.getString('user_id'),
      'question_id': widget.question_id
    });
    return QuestionDescriptionAnswerModel.fromJson(response);
  }

  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestionsDescription().then((value) {
      setState(() {
        questionsDescriptions = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'Patient Questions'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Question'),
                          Text(
                            questionsDescriptions.data.questoin,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Question Description'),
                          Text(
                            questionsDescriptions.data.description,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                      itemCount: questionsDescriptions.data.answers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 8.0,
                              left: 8,
                              right: 8,
                              bottom: 8,
                            ),
                            child: Card(
                              elevation: 5,
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
                                          questionsDescriptions
                                              .data.answers[index].doctorName,
                                          style: GoogleFonts.lato(
                                              color: Color(0xff252525),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '  ${questionsDescriptions.data.answers[index].date.day}/${questionsDescriptions.data.answers[index].date.month}/${questionsDescriptions.data.answers[index].date.year}',
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
                                      questionsDescriptions
                                          .data.answers[index].answer,
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
                        );
                      }),
                ),
                SizedBox(
                  height: navbarht + 20,
                )
              ],
            ),
    );
  }
}
