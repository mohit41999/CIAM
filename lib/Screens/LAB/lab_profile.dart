import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/LAB/all_labs_model.dart';
import 'package:patient/Models/LAB/all_packages_model.dart';
import 'package:patient/Models/LAB/all_test_model.dart';
import 'package:patient/Screens/LAB/all_labs.dart';
import 'package:patient/Screens/LAB/all_packages.dart';
import 'package:patient/Screens/LAB/all_test.dart';
import 'package:patient/Screens/LAB/contact_screen.dart';
import 'package:patient/Screens/LAB/lab_details.dart';
import 'package:patient/Screens/LAB/package_available_labs.dart';
import 'package:patient/Screens/LAB/prescription_screen.dart';
import 'package:patient/Screens/LAB/test_available_labs.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/LabController/lab_profile_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/common_row.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:patient/widgets/row_text_icon.dart';

class LabProfile extends StatefulWidget {
  const LabProfile({Key? key}) : super(key: key);

  @override
  _LabProfileState createState() => _LabProfileState();
}

class _LabProfileState extends State<LabProfile> {
  LABProfileController _controller = LABProfileController();

  Future initialize() async {
    await _controller.getallLabs().then((value) {
      setState(() {
        _controller.allLabs = value;
        _controller.labloading = false;
      });
    });
    await _controller.getallPackages().then((value) {
      setState(() {
        _controller.allPackages = value;
        _controller.packagesLoading = false;
      });
    });
    await _controller.getallTests().then((value) {
      setState(() {
        _controller.allTests = value;
        _controller.testloading = false;
      });
    });

    await _controller.getallOrgans().then((value) {
      setState(() {
        _controller.allOrgans = value;
        _controller.organsLoading = false;
      });
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
          centerTitle: false,
          title: commonAppBarTitle(),
          backgroundColor: Color(0xffEFEFEF),
          elevation: 0,
          titleSpacing: 0,
          leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.menu,
                onPressed: () {
                  setState(() {
                    Scaffold.of(context).openDrawer();
                  });
                }),
          )),
      drawer: commonDrawer(),
      body: RefreshIndicator(
        onRefresh: () {
          initialize();

          return _controller.getallPackages();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrescriptionWidget(),
              PhoneCallWidget(),
              SizedBox(
                height: 10,
              ),
              (_controller.packagesLoading)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Text(
                              'Health Checkups',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: appblueColor),
                            )),
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 3.85,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.only(
                          //       bottomLeft: Radius.circular(15),
                          //       bottomRight: Radius.circular(15)),
                          // ),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    )
                  : PackagesWidget(
                      allPackagesModel: _controller.allPackages,
                    ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Text(
                    //     'Tests',
                    //     style: GoogleFonts.montserrat(
                    //         color: appblueColor,
                    //         fontSize: 25,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: commonRow(
                        Title: 'Tests',
                        subTitle: 'View all',
                        value: AllTests(),
                      ),
                    ),
                    (_controller.testloading)
                        ? Center(child: CircularProgressIndicator())
                        : TestWidget(
                            allTestModel: _controller.allTests,
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: commonRow(
                  Title: 'Tests by Organs',
                  subTitle: 'View all',
                  value: AllTests(),
                ),
              ),
              (_controller.organsLoading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 2 / 2),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Icon(
                                    Icons.add,
                                    size: 40,
                                    color: apptealColor,
                                  )),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    _controller.allOrgans.data[index].organName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )))
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: _controller.allOrgans.data.length,
                      ),
                    ),
              (_controller.labloading)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Text(
                              'Labs',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: appblueColor),
                            )),
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 3.85,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.only(
                          //       bottomLeft: Radius.circular(15),
                          //       bottomRight: Radius.circular(15)),
                          // ),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    )
                  : LabsWidget(
                      allLabsModel: _controller.allLabs,
                    ),
              SizedBox(
                height: navbarht + 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabsWidget extends StatelessWidget {
  final AllLabsModel allLabsModel;
  const LabsWidget({
    Key? key,
    required this.allLabsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: commonRow(
              Title: 'Labs',
              subTitle: 'View all',
              value: AllLabs(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.85,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(15),
            //       bottomRight: Radius.circular(15)),
            // ),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: allLabsModel.data.length,
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
                                  flex: 1,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                allLabsModel.data[index].image),
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
                                        Text(allLabsModel.data[index].labname,
                                            style: KHeader),
                                        Text(
                                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et.',
                                            style: KBodyText),
                                        rowTextIcon(
                                          text:
                                              allLabsModel.data[index].location,
                                          asset: 'assets/pngs/Group 1182.png',
                                        ),
                                        Center(
                                          child: commonBtn(
                                            s: 'View LAB',
                                            bgcolor: appblueColor,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Push(
                                                  context,
                                                  LabDetails(
                                                    labid: allLabsModel
                                                        .data[index].labId,
                                                  ));
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
          ),
        ],
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final AllTestModel allTestModel;
  const TestWidget({
    Key? key,
    required this.allTestModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    allTestModel.data = allTestModel.data.take(4).toList();
    return SizedBox(
      height: 190,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(15),
      //       bottomRight: Radius.circular(15)),
      // ),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: allTestModel.data.length,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    allTestModel.data[index].testName,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: appblueColor),
                                  ),
                                  Text(
                                      (allTestModel.data[index].testDescription
                                                  .length >=
                                              150)
                                          ? allTestModel
                                                  .data[index].testDescription
                                                  .substring(0, 100) +
                                              '...'
                                          : allTestModel
                                              .data[index].testDescription,
                                      style:
                                          GoogleFonts.montserrat(fontSize: 10)),
                                  // Text(
                                  //   '₹ 199',
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
                                      bgcolor: appblueColor,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Push(
                                            context,
                                            TestsLabScreen(
                                              testId:
                                                  allTestModel.data[index].id,
                                              testDescription: allTestModel
                                                  .data[index].testDescription,
                                              testName: allTestModel
                                                  .data[index].testName,
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
                                      bottomRight: Radius.circular(15)),
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
    );
  }
}

class PackagesWidget extends StatelessWidget {
  final AllPackagesModel allPackagesModel;
  const PackagesWidget({
    Key? key,
    required this.allPackagesModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: commonRow(
              Title: 'Health Checkups',
              subTitle: 'View all',
              value: AllPackages(),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(15),
            //       bottomRight: Radius.circular(15)),
            // ),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: allPackagesModel.data.length,
                itemBuilder: (context, index) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    allPackagesModel.data[index].packgeName,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(allPackagesModel.data[index].packgeName,
                                      style:
                                          GoogleFonts.montserrat(fontSize: 10)),
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
                                              packageId: allPackagesModel
                                                  .data[index].packgeId,
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
          ),
        ],
      ),
    );
  }
}

class PhoneCallWidget extends StatelessWidget {
  const PhoneCallWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Push(context, LabContactScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // isThreeLine: true,
          style: ListTileStyle.drawer,
          minVerticalPadding: 0,
          tileColor: Colors.white,

          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_outlined,
                color: Colors.black,
              ),
            ],
          ),
          title: Text('Book Over a Phone Call'),
          subtitle: Text('Our team of experts will guide you'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 14,
          ),
        ),
      ),
    );
  }
}

class PrescriptionWidget extends StatelessWidget {
  const PrescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Push(context, UploadPrescriptionScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // isThreeLine: true,
          style: ListTileStyle.drawer,
          minVerticalPadding: 0,
          tileColor: Colors.white,

          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.black,
              ),
            ],
          ),
          title: Text('Have a Prescription?'),
          subtitle: Text('Upload and book your tests'),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 14,
          ),
        ),
      ),
    );
  }
}
