import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Screens/LAB/test_available_labs.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/LabController/lab_profile_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';

class AllTests extends StatefulWidget {
  const AllTests({Key? key}) : super(key: key);

  @override
  _AllTestsState createState() => _AllTestsState();
}

class _AllTestsState extends State<AllTests> {
  LABProfileController _controller = LABProfileController();

  Future initialize() async {
    _controller.allTests = await _controller.getallTests();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize().then((value) {
      setState(() {
        _controller.testloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: commonAppBarTitle(),
        backgroundColor: Color(0xffEFEFEF),
        elevation: 0,
        titleSpacing: 0,
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              setState(() {
                Pop(context);
              });
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Tests',
                style: GoogleFonts.montserrat(
                    color: appblueColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            (_controller.testloading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _controller.allTests.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10.0),
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
                                height: 170,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _controller.allTests.data[index]
                                                  .testName,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: appblueColor),
                                            ),
                                            Text(
                                                (_controller
                                                            .allTests
                                                            .data[index]
                                                            .testDescription
                                                            .length >=
                                                        150)
                                                    ? _controller
                                                            .allTests
                                                            .data[index]
                                                            .testDescription
                                                            .substring(0, 100) +
                                                        '...'
                                                    : _controller
                                                        .allTests
                                                        .data[index]
                                                        .testDescription,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10)),
                                            // Text(
                                            //   '₹ 199',
                                            //   style: GoogleFonts.montserrat(
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 16),
                                            // ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 4),
                                              child: commonBtn(
                                                borderRadius: 5,
                                                // width: 100,

                                                s: 'Book Now',
                                                textSize: 12,
                                                bgcolor: appblueColor,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  Push(
                                                      context,
                                                      TestsLabScreen(
                                                        testId: _controller
                                                            .allTests
                                                            .data[index]
                                                            .id,
                                                        testName: _controller
                                                            .allTests
                                                            .data[index]
                                                            .testName,
                                                        testDescription:
                                                            _controller
                                                                .allTests
                                                                .data[index]
                                                                .testDescription,
                                                      ));
                                                },
                                                height: 30,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/pngs/Rectangle-77.png'),
                                                fit: BoxFit.cover)),
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
            SizedBox(
              height: navbarht + 20,
            ),
          ],
        ),
      ),
    );
  }
}
