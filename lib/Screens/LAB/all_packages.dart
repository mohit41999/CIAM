import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Screens/LAB/lab_profile.dart';
import 'package:patient/Screens/LAB/package_available_labs.dart';
import 'package:patient/Screens/LAB/test_available_labs.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/LabController/lab_profile_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';

class AllPackages extends StatefulWidget {
  const AllPackages({Key? key}) : super(key: key);

  @override
  _AllPackagesState createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages> {
  LABProfileController _controller = LABProfileController();

  Future initialize() async {
    _controller.allPackages = await _controller.getallPackages();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize().then((value) {
      setState(() {
        _controller.packagesLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitle(),
        backgroundColor: Color(0xffEFEFEF),
        elevation: 0,
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
                'Health Checkups',
                style: GoogleFonts.montserrat(
                    color: appblueColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            (_controller.packagesLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3 / 4, crossAxisCount: 2),
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _controller.allPackages.data.length,
                    itemBuilder: (context, index) {
                      index = 0;
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(2, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/pngs/Rectangle 118.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _controller
                                            .allPackages.data[index].packgeName,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      Text(
                                          _controller.allPackages.data[index]
                                              .packgeName,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10)),
                                      // Text(
                                      //   '₹ ' +
                                      //       allPackagesModel.data[index].price
                                      //           .toString(),
                                      //   style: GoogleFonts.montserrat(
                                      //       fontWeight: FontWeight.bold,
                                      //       fontSize: 16),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 4),
                                        child: commonBtn(
                                          borderRadius: 5,
                                          // width: 100,

                                          s: 'Book Now',
                                          textSize: 12,
                                          bgcolor: apptealColor,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            Push(
                                                context,
                                                PackagesLabScreen(
                                                  packageId: _controller
                                                      .allPackages
                                                      .data[index]
                                                      .packgeId,
                                                ));
                                          },
                                          height: 30,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
