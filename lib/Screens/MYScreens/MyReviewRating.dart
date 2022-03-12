import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/my_review_ratings_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyReviewRatingsScreen extends StatefulWidget {
  const MyReviewRatingsScreen({Key? key}) : super(key: key);

  @override
  _MyReviewRatingsScreenState createState() => _MyReviewRatingsScreenState();
}

class _MyReviewRatingsScreenState extends State<MyReviewRatingsScreen> {
  bool loading = true;
  late MyReviewRatingModel myreviews;

  Future<MyReviewRatingModel> getmyreviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_patient_review_rating.php',
        params: {'token': Token, 'user_id': prefs.getString('user_id')});

    return MyReviewRatingModel.fromJson(response);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmyreviews().then((value) {
      setState(() {
        myreviews = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: commonAppBarTitleText(appbarText: 'My Reviews And Ratings'),
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
            ? Center(child: CircularProgressIndicator())
            : myreviews.data.length == 0
                ? Center(
                    child: Text('No reviews have been given'),
                  )
                : ListView.builder(
                    itemCount: myreviews.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            top: 10.0,
                            bottom: (index + 1 == myreviews.data.length)
                                ? navbarht + 20
                                : 10),
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(),
                                  title: Text(myreviews.data[index].doctorName),
                                  subtitle: RatingBarIndicator(
                                    rating: double.parse(
                                        myreviews.data[index].rating),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: apptealColor,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    unratedColor: Colors.grey.withOpacity(0.5),
                                    direction: Axis.horizontal,
                                  ),
                                  trailing: Text(
                                    myreviews.data[index].date,
                                    style: GoogleFonts.lato(
                                        color: apptealColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  myreviews.data[index].review,
                                  style: GoogleFonts.lato(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
  }
}
