import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/app_review.dart';
import 'package:patient/Models/home_care_categories_model.dart';
import 'package:patient/Models/hospital_packages_sub_cat_model.dart';
import 'package:patient/Models/statements_model.dart';
import 'package:patient/Screens/Home.dart';
import 'package:patient/Screens/TermsAndConditions.dart';
import 'package:patient/Screens/confirmScreen.dart';
import 'package:patient/Screens/contact_us_form.dart';
import 'package:patient/Screens/hospital_packages_categories.dart';
import 'package:patient/Screens/hospital_packages_sub_categories.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/app_review_controller.dart';
import 'package:patient/widgets/alertTextField.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/common_row.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:patient/widgets/tag_line.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/commonAppBarLeading.dart';

enum cities { Delhi, Gurugram, Lucknow, Mumbai, Bangalore }

class HospitalPackages extends StatefulWidget {
  const HospitalPackages({Key? key}) : super(key: key);

  @override
  _HospitalPackagesState createState() => _HospitalPackagesState();
}

class _HospitalPackagesState extends State<HospitalPackages> {
  TextEditingController care = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  List<HospitalPackagesSubCatModelData> hospitalPackagesSubCat = [];
  var selectedSubCat;
  var selectedCategroy;
  cities city = cities.Delhi;

  TextEditingController phonenumber = TextEditingController();
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String address = '';
  late HealthCareCategoriesModel hospitalPackages;
  bool loading = true;
  bool reviewloading = true;
  int _current = 0;
  List<StatementsModelData> statements = [];
  late AppReviewModel appReviewdata;
  final CarouselController _controller = CarouselController();
  final CarouselController _reviewcontroller = CarouselController();

  AppReviewController _appReviewController = AppReviewController();
  List<Widget> widgetSliders(BuildContext context) => hometile
      .map((item) => Container(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffF6F6F6),
              borderRadius: BorderRadius.circular(5),
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
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 160,
                        child: Text(
                          item['label'],
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: appblueColor,
                              fontWeight: FontWeight.bold),
                        ),
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
                        s: 'Consult Now',
                        bgcolor: appblueColor,
                        textColor: Colors.white,
                        onPressed: () {
                          (item['Screen'] == 'null')
                              ? print('nooooooo')
                              : Push(context, item['Screen']);
                        },
                        width: 120,
                        height: 30,
                        textSize: 12,
                        borderRadius: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/pngs/${item['profile']}',
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          )))
      .toList();

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
    gethomecareServices().then((value) {
      setState(() {
        hospitalPackages = value;
        loading = false;
      });
    });
    _appReviewController.getappReview(context).then((value) {
      setState(() {
        appReviewdata = value;
        reviewloading = false;
      });
    });
    getStatements().then((value) {
      setState(() {
        statements = value.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
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
        ),
      ),
      drawer: commonDrawer(),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: CarouselSlider(
                            items: widgetSliders(context),
                            carouselController: _controller,
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
                        children: hometile.asMap().entries.map((entry) {
                          return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Color(0xffF1F1F1),
                    //padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Consult our trusted surgical specialities for FREE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Best end-to-end surgical speciality for 50+ ailment',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Let\'s schedule your appointment',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Where is the care needed?'),
                          SizedBox(
                            height: 5,
                          ),
                          // CSCPicker(
                          //   showCities: true,
                          //
                          //   defaultCountry: DefaultCountry.India,
                          //   disableCountry: true,
                          //   showStates: true,
                          //   layout: Layout.vertical,
                          //
                          //   flagState: CountryFlag.DISABLE,
                          //
                          //   dropdownDecoration: BoxDecoration(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10)),
                          //       color: Colors.white,
                          //       boxShadow: [
                          //         BoxShadow(
                          //             color: Colors.grey.withOpacity(0.5),
                          //             offset: Offset(0, 5),
                          //             spreadRadius: 1,
                          //             blurRadius: 2)
                          //       ]),
                          //
                          //   disabledDropdownDecoration: BoxDecoration(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10)),
                          //       color: Colors.white,
                          //       boxShadow: [
                          //         BoxShadow(
                          //             color: Colors.grey.withOpacity(0.5),
                          //             offset: Offset(0, 5),
                          //             spreadRadius: 1,
                          //             blurRadius: 2)
                          //       ],
                          //       border:
                          //           Border.all(color: Colors.white, width: 1)),
                          //
                          //   ///Default Country
                          //
                          //   ///selected item style [OPTIONAL PARAMETER]
                          //   selectedItemStyle: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 14,
                          //   ),
                          //
                          //   ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                          //   dropdownHeadingStyle: TextStyle(
                          //       color: Colors.red,
                          //       fontSize: 17,
                          //       fontWeight: FontWeight.bold),
                          //
                          //   ///DropdownDialog Item style [OPTIONAL PARAMETER]
                          //   dropdownItemStyle: GoogleFonts.poppins(
                          //     color: Colors.black,
                          //     fontSize: 14,
                          //   ),
                          //
                          //   ///Dialog box radius [OPTIONAL PARAMETER]
                          //   dropdownDialogRadius: 10.0,
                          //
                          //   ///Search bar radius [OPTIONAL PARAMETER]
                          //   searchBarRadius: 10.0,
                          //
                          //   ///triggers once country selected in dropdown
                          //   onCountryChanged: (value) {
                          //     setState(() {
                          //       ///store value in country variable
                          //       countryValue = value;
                          //       print(countryValue);
                          //     });
                          //   },
                          //
                          //   ///triggers once state selected in dropdown
                          //   onStateChanged: (value) {
                          //     setState(() {
                          //       ///store value in state variable
                          //       stateValue = value;
                          //     });
                          //   },
                          //
                          //   ///triggers once city selected in dropdown
                          //   onCityChanged: (value) {
                          //     setState(() {
                          //       ///store value in city variable
                          //       cityValue = value;
                          //     });
                          //   },
                          // ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Delhi,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Delhi')
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Bangalore,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Bangalore')
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Gurugram,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Gurugram')
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Lucknow,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Lucknow')
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Mumbai,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Mumbai')
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 55),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
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

                                controller: care,
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
                                  labelText: 'Enter Postal Code',
                                  alignLabelWithHint: false,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,

                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.6)),
                                  // hintText: textFieldtext,
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          alertTextField(
                              controller: name,
                              label: 'Name',
                              textFieldtext: 'Enter Full Name'),
                          SizedBox(
                            height: 15,
                          ),
                          alertTextField(
                              controller: email,
                              label: 'Email',
                              textFieldtext: 'Enter Email Id'),
                          SizedBox(
                            height: 15,
                          ),
                          alertTextField(
                              inputType: TextInputType.number,
                              controller: phonenumber,
                              label: 'Phone Number',
                              textFieldtext: 'Enter Phone Number'),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Select Category'),
                          SizedBox(
                            height: 5,
                          ),
                          Material(
                            elevation: 5,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 10, right: 20),
                              width: double.infinity,
                              child: DropdownButton(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                underline: Container(),
                                dropdownColor: Colors.white,

                                isExpanded: true,

                                // Initial Value
                                hint: Text(
                                  'Category',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: hospitalPackages.data
                                    .map((HealthCareCategoriesModelData items) {
                                  return DropdownMenuItem(
                                    value: items.serviceId,
                                    child: Text(items.serviceName),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (newValue) {
                                  setState(() {
                                    hospitalPackagesSubCat = [];
                                    selectedSubCat = null;
                                    print(newValue);
                                    selectedCategroy = newValue.toString();
                                    getHospitalPackagesSubCat(selectedCategroy)
                                        .then((value) {
                                      hospitalPackagesSubCat = value.data;
                                    });
                                  });
                                },
                                value: selectedCategroy,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Select Sub Category'),
                          SizedBox(
                            height: 5,
                          ),
                          Material(
                            elevation: 5,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 10, right: 20),
                              width: double.infinity,
                              child: DropdownButton(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                underline: Container(),
                                dropdownColor: Colors.white,

                                isExpanded: true,

                                // Initial Value
                                hint: Text(
                                  'Sub Category',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: hospitalPackagesSubCat.map(
                                    (HospitalPackagesSubCatModelData items) {
                                  return DropdownMenuItem(
                                    value: items.subPackageId,
                                    child: Text(items.name),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (newValue) {
                                  setState(() {
                                    print(newValue);
                                    selectedSubCat = newValue.toString();
                                  });
                                },
                                value: selectedSubCat,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: commonBtn(
                              s: 'Submit Care',
                              bgcolor: Color(0xff161616).withOpacity(0.6),
                              textColor: Colors.white,
                              onPressed: () {
                                addCareServices(context,
                                        city: cityValue ?? '',
                                        subcareid: selectedSubCat.toString(),
                                        careid: selectedCategroy.toString(),
                                        name: name.text,
                                        email: email.text,
                                        phone: phonenumber.text,
                                        care_requirement: care.text)
                                    .then((value) {
                                  if (value) {
                                    name.clear();
                                    email.clear();
                                    phonenumber.clear();
                                    care.clear();
                                  }
                                });
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, bottom: 16, top: 8),
                      child: commonRow(
                        Title: 'Surgical Solution for \n50+ Ailments',
                        subTitle: 'View all',
                        value: HospitalPackageCategories(),
                      ),
                    ),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: hospitalPackages.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Push(
                                context,
                                HospitalPackageSubCat(
                                  cat_id:
                                      hospitalPackages.data[index].serviceId,
                                  cat_name:
                                      hospitalPackages.data[index].serviceName,
                                  fromHome: true,
                                ));
                          },
                          child: Column(
                            children: [
                              Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                hospitalPackages
                                                    .data[index].image),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            hospitalPackages
                                                .data[index].serviceName,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 20,
                                                color: appblueColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Center(
                                          child: Icon(Icons.arrow_forward_ios))
                                    ],
                                  ),
                                ),
                              ),
                              (index + 1 == hospitalPackages.data.length)
                                  ? SizedBox()
                                  : Divider(
                                      height: 0,
                                      color: Colors.black,
                                    )
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Why to Choose',
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  color: appblueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size:
                                      MediaQuery.of(context).size.width * 0.25,
                                ),
                                Expanded(
                                  child: Text(
                                    'Experienced Doctor',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size:
                                      MediaQuery.of(context).size.width * 0.25,
                                ),
                                Expanded(
                                  child: Text(
                                    '3 day chat option to ask query',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size:
                                      MediaQuery.of(context).size.width * 0.25,
                                ),
                                Expanded(
                                  child: Text(
                                    '3 day chat option to ask query',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(),
                                  ),
                                )
                              ],
                            ),
                            commonBtn(
                                s: 'Consult Now',
                                bgcolor: appblueColor,
                                textColor: Colors.white,
                                borderRadius: 10,
                                onPressed: () {
                                  Push(context, HospitalPackageCategories());
                                })
                          ],
                        ),
                      )),
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
                                                  ? appblueColor
                                                      .withOpacity(0.9)
                                                  : appblueColor
                                                      .withOpacity(0.4),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appblueColor,
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'You are in Safe Hands,',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'every step of the way',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Image.asset('assets/pngs/nursedoctor.png'),
                            ],
                          ),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: statements.length,
                            itemBuilder: (context, index) {
                              return adminStatements(
                                  text: statements[index].statement);
                            }),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                                color: Colors.white
                                                    .withOpacity(1)),
                                          )
                                        ],
                                      )),
                                  // SizedBox(
                                  //   height: 40,
                                  //   width: double.infinity,
                                  //   child: TextButton(
                                  //     style: ButtonStyle(
                                  //         backgroundColor:
                                  //             MaterialStateProperty.all<Color>(appblueColor),
                                  //         shape:
                                  //             MaterialStateProperty.all<RoundedRectangleBorder>(
                                  //                 RoundedRectangleBorder(
                                  //           borderRadius: BorderRadius.only(
                                  //               bottomLeft: Radius.circular(15),
                                  //               bottomRight: Radius.circular(15)),
                                  //         ))),
                                  //     onPressed: () {},
                                  //     child: Text(
                                  //       'Contact Us',
                                  //       style: GoogleFonts.montserrat(
                                  //           fontSize: 12,
                                  //           color: Colors.white,
                                  //           letterSpacing: 1,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ),
                                  // )
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

  Future<HealthCareCategoriesModel> gethomecareServices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response = await PostData(
        PARAM_URL: 'get_hospital_packages_category.php',
        params: {'user_id': preferences.getString('user_id'), 'token': Token});

    return HealthCareCategoriesModel.fromJson(response);
  }

  Future<StatementsModel> getStatements() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response = await PostData(
        PARAM_URL: 'get_hospital_package_statements.php',
        params: {'user_id': preferences.getString('user_id'), 'token': Token});

    return StatementsModel.fromJson(response);
  }

  Future<HospitalPackagesSubCatModel> getHospitalPackagesSubCat(
      String cat_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_hospital_packages_sub_category.php',
        params: {
          'token': Token,
          'cat_id': cat_id,
          'user_id': preferences.getString('user_id')
        });

    return HospitalPackagesSubCatModel.fromJson(response);
  }

  Future<bool> addCareServices(
    BuildContext context, {
    required String subcareid,
    required String careid,
    required String name,
    required String email,
    required String city,
    required String phone,
    required String care_requirement,
  }) async {
    if (care_requirement.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter care requirement'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter name'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter email'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter phone number'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (careid.isEmpty || careid == 'null') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select Category '),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (subcareid.isEmpty || subcareid == 'null') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select Sub Category'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (care_requirement.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Postal Code must be 6 characters only'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else {
      var loader = ProgressView(context);
      try {
        loader.show();
        late Map<String, dynamic> data;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await PostData(
            PARAM_URL: 'add_hospital_package_requirement.php',
            params: {
              'token': Token,
              'user_id': prefs.getString('user_id'),
              'name': name,
              'email': email,
              'phone': phone,
              'city': '1',
              'package_category_id': careid,
              'package_subcategory_id': subcareid,
              'postal_code': care_requirement,
            }).then((value) {
          loader.dismiss();
          if (value['status']) {
            loader.dismiss();
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text(value['message']),
            //   backgroundColor: apptealColor,
            // ));

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ConfirmScreen(text: value['message'])));

            return true;
          } else {
            loader.dismiss();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value['message']),
              backgroundColor: Colors.red,
            ));
            return false;
          }
        });
        loader.dismiss();
        return true;
      } catch (e) {
        loader.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong... try again later'),
          backgroundColor: Colors.red,
        ));
        return false;
      }
    }
  }
}

class adminStatements extends StatelessWidget {
  final String text;
  const adminStatements({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_outlined,
            size: 30,
            color: Colors.grey,
          ),
          Text('  '),
          Expanded(
              child: Text(
            text,
            style: GoogleFonts.montserrat(color: Colors.grey),
          )),
        ],
      ),
    );
  }
}
