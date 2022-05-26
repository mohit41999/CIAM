import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/knowledge_forum_model.dart';
import 'package:patient/Screens/knowledge_description_screen.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KnowledgeForumScreen extends StatefulWidget {
  const KnowledgeForumScreen({Key? key}) : super(key: key);

  @override
  _KnowledgeForumScreenState createState() => _KnowledgeForumScreenState();
}

class _KnowledgeForumScreenState extends State<KnowledgeForumScreen> {
  late KnowledgeForumModel data;
  bool loading = true;

  TextEditingController searchController = TextEditingController();
  Future<KnowledgeForumModel> getForums() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: 'get_knowledge_forum_listing.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
    });

    return KnowledgeForumModel.fromJson(response);
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
    getForums().then((value) {
      setState(() {
        data = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                        child: TextFormField(
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
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            (loading)
                                ? Center(child: CircularProgressIndicator())
                                : ListView.builder(
                                    itemCount: data.data.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return (searchController.text.isEmpty)
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            KnowledgeDescription(
                                                                forum_id: data
                                                                    .data[index]
                                                                    .forumId))).then(
                                                    (value) {
                                                  getForums().then((value) {
                                                    setState(() {
                                                      data = value;
                                                    });
                                                  });
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 8),
                                                child: Card(
                                                  elevation: 5,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 16),
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
                                                              data.data[index]
                                                                  .doctorName,
                                                              style: GoogleFonts.lato(
                                                                  color: Color(
                                                                      0xff252525),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              data.data[index]
                                                                      .date.day
                                                                      .toString() +
                                                                  '/' +
                                                                  data
                                                                      .data[
                                                                          index]
                                                                      .date
                                                                      .month
                                                                      .toString() +
                                                                  '/' +
                                                                  data
                                                                      .data[
                                                                          index]
                                                                      .date
                                                                      .year
                                                                      .toString(),
                                                              style: GoogleFonts.lato(
                                                                  color:
                                                                      apptealColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                                                  color: Color(
                                                                      0xff252525),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              data.data[index]
                                                                  .category_name
                                                                  .toString(),
                                                              style: GoogleFonts.lato(
                                                                  color: Color(
                                                                      0xff252525),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                                            Expanded(
                                                              child: Text(
                                                                data.data[index]
                                                                    .knowledgeTitle,
                                                                style: GoogleFonts.lato(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                reportDialog(data
                                                                    .data[index]
                                                                    .forumId);
                                                              },
                                                              child: Text(
                                                                'Report',
                                                                style: GoogleFonts.lato(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : (data.data[index].doctorName
                                                      .toLowerCase()
                                                      .replaceAll(' ', '')
                                                      .contains(searchController
                                                          .text
                                                          .toLowerCase()
                                                          .replaceAll(
                                                              ' ', '')) ||
                                                  data.data[index]
                                                      .knowledgeTitle
                                                      .toLowerCase()
                                                      .replaceAll(' ', '')
                                                      .contains(searchController
                                                          .text
                                                          .toLowerCase()
                                                          .replaceAll(' ', '')))
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                KnowledgeDescription(
                                                                    forum_id: data
                                                                        .data[
                                                                            index]
                                                                        .forumId))).then(
                                                        (value) {
                                                      getForums().then((value) {
                                                        setState(() {
                                                          data = value;
                                                        });
                                                      });
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0,
                                                        left: 8,
                                                        right: 8,
                                                        bottom: 8),
                                                    child: Card(
                                                      elevation: 5,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 16),
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
                                                                  data
                                                                      .data[
                                                                          index]
                                                                      .doctorName,
                                                                  style: GoogleFonts.lato(
                                                                      color: Color(
                                                                          0xff252525),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  data
                                                                          .data[
                                                                              index]
                                                                          .date
                                                                          .day
                                                                          .toString() +
                                                                      '/' +
                                                                      data
                                                                          .data[
                                                                              index]
                                                                          .date
                                                                          .month
                                                                          .toString() +
                                                                      '/' +
                                                                      data
                                                                          .data[
                                                                              index]
                                                                          .date
                                                                          .year
                                                                          .toString(),
                                                                  style: GoogleFonts.lato(
                                                                      color:
                                                                          apptealColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
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
                                                                      color: Color(
                                                                          0xff252525),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  data
                                                                      .data[
                                                                          index]
                                                                      .category_name
                                                                      .toString(),
                                                                  style: GoogleFonts.lato(
                                                                      color: Color(
                                                                          0xff252525),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
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
                                                                Expanded(
                                                                  child: Text(
                                                                    data
                                                                        .data[
                                                                            index]
                                                                        .knowledgeTitle,
                                                                    style: GoogleFonts.lato(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    reportDialog(data
                                                                        .data[
                                                                            index]
                                                                        .forumId);
                                                                  },
                                                                  child: Text(
                                                                    'Report',
                                                                    style: GoogleFonts.lato(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .red,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                    }),
                            Container(
                              color: Colors.transparent,
                              height: navbarht + 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: navbarht + 20,
                  )
                ],
              ),
            ),
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
                          data = await getForums();

                          Pop(context);
                          setState(() {});
                        }),
                  ],
                )
              ],
            ));
  }
}
