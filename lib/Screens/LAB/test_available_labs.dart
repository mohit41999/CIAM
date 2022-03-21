import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/test_available_lab_model.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile.dart';
import 'package:patient/Screens/LAB/test_checkout.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/common_row.dart';
import 'package:patient/widgets/doctor_profile_row.dart';
import 'package:patient/widgets/row_text_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestsLabScreen extends StatefulWidget {
  final String testId;
  final String testName;
  final String testDescription;

  const TestsLabScreen({
    Key? key,
    required this.testId,
    required this.testName,
    required this.testDescription,
  }) : super(key: key);

  @override
  _TestsLabScreenState createState() => _TestsLabScreenState();
}

class _TestsLabScreenState extends State<TestsLabScreen> {
  late TestAvailableLabsModel availableLabs;
  Future<TestAvailableLabsModel> getavailableLabs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response =
        await PostData(PARAM_URL: 'get_test_available_labs.php', params: {
      'token': Token,
      'user_id': preferences.getString('user_id'),
      'test_id': widget.testId,
      'city': preferences.getString('city')
    });
    return TestAvailableLabsModel.fromJson(response);
  }

  bool loading = true;

  Future initialize() async {
    availableLabs = await getavailableLabs();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 40,
                color: Colors.white,
                width: double.infinity,
                child: Center(
                    child: Text(
                  'Test Details',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: appblueColor,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        doctorProfileRow(
                            title: 'Test Name', value: widget.testName),
                        SizedBox(
                          height: 10,
                        ),
                        doctorProfileRow(
                            title: 'Test Description',
                            value: widget.testDescription),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 40,
                color: Colors.white,
                width: double.infinity,
                child: Center(
                    child: Text(
                  'Available Labs',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: appblueColor,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            (loading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: availableLabs.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: 10.0,
                            right: 10.0,
                            left: 10.0,
                            bottom: (index + 1 == availableLabs.data.length)
                                ? navbarht + 21
                                : 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(2, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 200,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft:
                                                    Radius.circular(15)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    availableLabs
                                                        .data[index].labImage),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              availableLabs.data[index].labName,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            // Text(
                                            //   'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et.',
                                            //   style: GoogleFonts.montserrat(
                                            //     fontSize: 12,
                                            //   ),
                                            // ),
                                            rowTextIcon(
                                              text: ' Location',
                                              asset:
                                                  'assets/pngs/Group 1182.png',
                                            ),
                                            Text(
                                              '₹ ${availableLabs.data[index].testPrice}',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Center(
                                              child: commonBtn(
                                                s: 'Book Now',
                                                bgcolor: appblueColor,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  Push(
                                                      context,
                                                      TestCheckout(
                                                        labid: availableLabs
                                                            .data[index].labId,
                                                        testids: [
                                                          widget.testId
                                                        ],
                                                      ),
                                                      withnav: false);
                                                },
                                                height: 30,
                                                width: 180,
                                                textSize: 12,
                                                borderRadius: 4,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
