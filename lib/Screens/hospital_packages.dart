import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/app_review.dart';
import 'package:patient/Models/home_care_categories_model.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_3.dart';
import 'package:patient/Screens/HomeCareCategories.dart';
import 'package:patient/Screens/contact_us_form.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/app_review_controller.dart';
import 'package:patient/widgets/alertTextField.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/common_row.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:patient/widgets/patient_home_page_4_alert_box.dart';
import 'package:patient/widgets/tag_line.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalPackages extends StatefulWidget {
  const HospitalPackages({Key? key}) : super(key: key);

  @override
  _HospitalPackagesState createState() => _HospitalPackagesState();
}

class _HospitalPackagesState extends State<HospitalPackages> {
  List<String> _packagesName = [
    'WHOLE BODY CHECK',
    'WOMEN CHECK',
    'HEART CHECK',
    'CITIZEN CHECK',
    'BLOOD CHECK'
  ];
  TextEditingController care = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  bool loading = true;

  bool reviewloading = true;
  int _current = 0;
  late AppReviewModel appReviewdata;

  final CarouselController _reviewcontroller = CarouselController();

  AppReviewController _appReviewController = AppReviewController();

  List<Widget> Review(BuildContext context) => appReviewdata.data
      .map((item) => Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(2, 2),
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 2)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/pngs/Rectangle 69.png'),
                    ),
                    title: Text(item.userName),
                    subtitle: RatingBarIndicator(
                      rating: double.parse(item.rating),
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
                      item.date,
                      style: GoogleFonts.lato(
                          color: apptealColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      item.review,
                      style: GoogleFonts.lato(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )))
      .toList();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _appReviewController.getappReview(context).then((value) {
      setState(() {
        appReviewdata = value;
        reviewloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) => GestureDetector(
              child: Container(
                width: 30,
                height: 30,
                child: Center(
                  child: Icon(
                    Icons.menu,
                    color: appblueColor,
                    size: 20,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  Scaffold.of(context).openDrawer();
                });
              },
            ),
          ),
        ),
      ),
      drawer: commonDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GestureDetector(
            //   onTap: () {},
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Container(
            //       height: 40,
            //       width: double.infinity,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(5),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.5),
            //             blurRadius: 10,
            //             offset: const Offset(2, 5),
            //           ),
            //         ],
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.search,
            //             color: Color(0xff161616).withOpacity(0.6),
            //           ),
            //           SizedBox(
            //             width: 15,
            //           ),
            //           Text(
            //             'Search',
            //             style: GoogleFonts.montserrat(
            //                 fontSize: 16,
            //                 color: Color(0xff161616).withOpacity(0.6)),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),

            Container(
              color: Colors.white,
              width: double.infinity,
              height: 320,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: commonRow(
                      Title: 'Hospital Packages',
                      subTitle: 'View all',
                      value: HomeCareCategories(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 250,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // maxCrossAxisExtent: 100,
                          childAspectRatio: 3 / 4,
                          // crossAxisSpacing: 10,
                          // mainAxisSpacing: 10,
                          crossAxisCount: 2),
                      itemCount: _packagesName.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              hospitalPackageAlert(context,
                                  careController: care,
                                  nameController: name,
                                  emailController: email,
                                  phonenumberController: phonenumber,
                                  packageName: _packagesName[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(2, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        Icons.medical_services,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          _packagesName[index],
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color(0xffF6F6F6),
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(2, 5),
                              ),
                            ],
                          ),
                          // height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Physiotherapy At Home',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          color: appblueColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 160,
                                      child: Text(
                                        'India\'s largest home health care company',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Color(0xff161616),
                                        ),
                                      ),
                                    ),
                                    commonBtn(
                                      s: 'Know More',
                                      bgcolor: Colors.black.withOpacity(0.4),
                                      textColor: Colors.white,
                                      onPressed: () {
                                        // Push(context, DoctorProfile1());
                                      },
                                      width: 120,
                                      height: 30,
                                      textSize: 12,
                                      borderRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset('assets/pngs/nursedoctor.png')
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 20,
            ),
            (reviewloading)
                ? Center(child: CircularProgressIndicator())
                : Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'See our User Experiences',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: appblueColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Column(children: [
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: CarouselSlider(
                                  items: Review(context),
                                  carouselController: _reviewcontroller,
                                  options: CarouselOptions(
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      aspectRatio: 2.5,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: appReviewdata.data
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                return GestureDetector(
                                    onTap: () => _reviewcontroller
                                        .animateToPage(entry.key),
                                    child: Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == entry.key
                                            ? appblueColor.withOpacity(0.9)
                                            : appblueColor.withOpacity(0.4),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Push(context, ContactUsForm());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: appblueColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(2, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/pngs/customer_support.jpg'),
                                fit: BoxFit.contain,
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Contact Us',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'If you have any query ... you can Contact Us here',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(1)),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TagLine(),
            SizedBox(
              height: navbarht + 20,
            ),
          ],
        ),
      ),
    );
  }
}

void hospitalPackageAlert(BuildContext context,
    {required TextEditingController careController,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phonenumberController,
    required String packageName}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          backgroundColor: Color(0xffF1F1F1),
          elevation: 0,
          insetPadding: EdgeInsets.all(15),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hospital Package Inquiry',
                    style: GoogleFonts.montserrat(
                        color: appblueColor, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close)),
                ],
              ),
              Divider(color: Colors.grey),
            ],
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            color: Color(0xffF1F1F1),
            //padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Package'),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 55),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            readOnly: true,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,

                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            // validator: validator,
                            // maxLength: maxLength,
                            // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                            enableSuggestions: true,

                            decoration: InputDecoration(
                              enabled: false,
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

                              hintText: packageName,

                              labelStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.6)),

                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  alertTextField(
                    controller: careController,
                    label: 'Where is care needed?',
                    textFieldtext: 'Enter Postal Code',
                    inputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  alertTextField(
                      controller: nameController,
                      label: 'Name',
                      textFieldtext: 'Enter Full Name'),
                  SizedBox(
                    height: 10,
                  ),
                  alertTextField(
                      controller: emailController,
                      label: 'Email',
                      textFieldtext: 'Enter Email Id'),
                  SizedBox(
                    height: 10,
                  ),
                  alertTextField(
                      controller: phonenumberController,
                      label: 'Phone Number',
                      textFieldtext: 'Enter Phone Number'),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: commonBtn(
                      s: 'Submit',
                      bgcolor: Color(0xff161616).withOpacity(0.6),
                      textColor: Colors.white,
                      onPressed: () {
                        Pop(context);
                      },
                      height: 40,
                      width: 115,
                      borderRadius: 4,
                      textSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )));
}
