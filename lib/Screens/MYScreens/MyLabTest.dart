import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/MyModels/my_lab_test_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/title_column.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLabTest extends StatefulWidget {
  const MyLabTest({Key? key}) : super(key: key);

  @override
  _MyLabTestState createState() => _MyLabTestState();
}

class _MyLabTestState extends State<MyLabTest> {
  late MyLabTestModel myLabTests;

  Future<MyLabTestModel> getMyLabTests() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'my_lab_tests.php',
        params: {'token': Token, 'user_id': preferences.getString('user_id')});

    return MyLabTestModel.fromJson(response);
  }

  bool loading = true;
  Future initialize() async {
    myLabTests = await getMyLabTests();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'My LAB Test'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: myLabTests.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 10.0,
                        bottom: (index + 1 == myLabTests.data.length)
                            ? navbarht + 20
                            : 10),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
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
                            height: 130,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(150),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/pngs/Rectangle-77.png',
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Expanded(
                                  // flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              titleColumn(
                                                title: 'Test Name',
                                                value: myLabTests
                                                    .data[index].testName,
                                              ),
                                              titleColumn(
                                                value: myLabTests
                                                    .data[index].bookingDate,
                                                title: 'Date of Booking',
                                              ),
                                              titleColumn(
                                                value: '₹ ' +
                                                    myLabTests.data[index]
                                                        .ammountPaid,
                                                title: 'AmountPaid',
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Invoice & Report',
                                                    style: GoogleFonts.lato(
                                                        fontSize: 12,
                                                        color: Color(0xff252525)
                                                            .withOpacity(0.5)),
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.eye,
                                                    size: 14,
                                                    color: appblueColor,
                                                  ),
                                                  Container(
                                                    height: 14,
                                                    width: 14,
                                                    child: Image.asset(
                                                        'assets/pngs/Icon feather-download.png'),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        // Expanded(
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.only(
                                        //         right: 10.0),
                                        //     child: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.start,
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: [
                                        //
                                        //
                                        //         titleColumn(
                                        //           title: 'Amount',
                                        //           value: '\$199',
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ))),
                              onPressed: () {},
                              child: Text(
                                'Need Help ?',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: appblueColor,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
