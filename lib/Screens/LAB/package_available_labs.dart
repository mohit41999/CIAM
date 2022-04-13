import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/LAB/package_available_lab_model.dart';
import 'package:patient/Models/LAB/package_details_model.dart';
import 'package:patient/Screens/LAB/package_checkout.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/LabController/package_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/doctor_profile_row.dart';
import 'package:patient/widgets/row_text_icon.dart';

class PackagesLabScreen extends StatefulWidget {
  final String packageId;
  const PackagesLabScreen({Key? key, required this.packageId})
      : super(key: key);

  @override
  _PackagesLabScreenState createState() => _PackagesLabScreenState();
}

class _PackagesLabScreenState extends State<PackagesLabScreen> {
  late PackageAvailableLabModel availableLabs;
  late PackageDetailsModel packageDetails;
  bool labloading = true;
  bool pdloading = true;
  PackageController _controller = PackageController();
  Future initialize() async {
    availableLabs = await _controller.getAvailableLabs(widget.packageId);
    setState(() {
      labloading = false;
    });
    packageDetails = await _controller.getpackagedetails(widget.packageId);
    setState(() {
      pdloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    initialize();
    super.initState();
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
                  'Package Details',
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
                  height: MediaQuery.of(context).size.height / 3,
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        doctorProfileRow(
                            title: 'Package Name',
                            value: packageDetails.data.packgeName),
                        Container(
                          height: 40,
                          color: Colors.grey.withOpacity(0.2),
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            'Tests Included',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: appblueColor,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: packageDetails.data.labTest.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 2,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          packageDetails
                                              .data.labTest[index].testName,
                                          style: GoogleFonts.montserrat(
                                              color: apptealColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
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
            (labloading)
                ? CircularProgressIndicator()
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
                            bottom: (index + 1 == 10) ? navbarht + 21 : 10.0),
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
                                              availableLabs
                                                  .data[index].packagePrice,
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
                                                  Push(context,
                                                      PackageCheckout(),
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
