import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/knowledge_description_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KnowledgeDescription extends StatefulWidget {
  final String forum_id;
  const KnowledgeDescription({Key? key, required this.forum_id})
      : super(key: key);

  @override
  _KnowledgeDescriptionState createState() => _KnowledgeDescriptionState();
}

class _KnowledgeDescriptionState extends State<KnowledgeDescription> {
  late KnowledgeDescriptionModel data;
  bool loading = true;
  Future<KnowledgeDescriptionModel> getMyForumDescription() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_knowledge_forum_description.php',
        params: {
          'token': Token,
          'user_id': prefs.getString('user_id'),
          'forum_id': widget.forum_id
        });

    return KnowledgeDescriptionModel.fromJson(response);
  }

  Future report(String forum_id) async {
    var loader = ProgressView(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loader.show();
    var response;
    try {
      response = await PostData(
          PARAM_URL: AppEndPoints.report_knowledge_forum,
          params: {
            'token': Token,
            'user_id': prefs.getString('user_id'),
            'forum_id': forum_id
          });

      loader.dismiss();
      if (response['status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Reported Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Try again later'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      loader.dismiss();
      print(e);
    }
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyForumDescription().then((value) {
      setState(() {
        data = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: commonAppBarTitleText(appbarText: 'Knowledge Forum'),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              (loading)
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: GoogleFonts.lato(
                                color: Color(0xff252525),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.data.knowledgeTitle,
                                      style: GoogleFonts.lato(
                                          color: Color(0xff252525),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        data.data.date.day.toString() +
                                            '/' +
                                            data.data.date.month.toString() +
                                            '/' +
                                            data.data.date.year.toString(),
                                        style: GoogleFonts.lato(
                                            color: apptealColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.red)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              'Report',
                                              style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          reportDialog(widget.forum_id);
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
                            color: Colors.transparent,
                          ),
                          Text(
                            'Description',
                            style: GoogleFonts.lato(
                                color: Color(0xff252525),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data.data.knowledgeDescription,
                                style: GoogleFonts.montserrat(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ));
  }

  Future reportDialog(String forum_id) async {
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are you sure you want to report ?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonBtn(
                        width: 100,
                        s: 'No',
                        bgcolor: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          Pop(context);
                        }),
                    commonBtn(
                        width: 100,
                        s: 'Yes',
                        bgcolor: Colors.green,
                        textColor: Colors.white,
                        onPressed: () async {
                          await report(forum_id);

                          Pop(context);
                          Pop(context);
                          setState(() {});
                        }),
                  ],
                )
              ],
            ));
  }
}
