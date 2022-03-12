import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/doctor_profile_model.dart';
import 'package:patient/Models/home_doctor_speciality_model.dart';
import 'package:patient/Screens/search_screen.dart';

import 'package:patient/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/DoctorProfileController/doctor_controller.dart';
import 'package:patient/controller/home_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:patient/widgets/row_text_icon.dart';

import 'doctor_profile_1.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({
    Key? key,
    required this.fromhome,
    this.isSpecial = false,
    this.speciality_id = '',
  }) : super(key: key);
  final bool fromhome;
  final bool isSpecial;
  final String speciality_id;

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

enum Gender { male, female }

class _DoctorProfileState extends State<DoctorProfile> {
  DoctorController _con = DoctorController();
  TextStyle titleStyle =
      GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold);
  double _value = 0;
  RangeValues currentRangeValues = const RangeValues(18, 40);

  late HomeDoctorSpecialityModel specialities;
  late DoctorProfileModel _doctordata;
  late List<bool> _isChecked;

  @override
  void initState() {
    // TODO: implement initState
    _con.getDoctor(context).then((value) {
      setState(() {
        _doctordata = value;
        _con.loading = false;
      });
    });
    HomeController().getDoctorSpecilities(context).then((value) {
      setState(() {
        specialities = value;
        _isChecked = List<bool>.filled(specialities.data.length, false);
        // _con.specialitybool = false;
      });
    });
    super.initState();
  }

  ScrollController _controller = ScrollController();
  Gender gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )),
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return StatefulBuilder(builder: (BuildContext context,
                      StateSetter setState /*You can rename this!*/) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Pop(context),
                      child: GestureDetector(
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.7,
                          minChildSize: 0.5,
                          maxChildSize: 0.9,
                          builder: (_, _controller) => Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: ListView(
                              controller: _controller,
                              // mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Category',
                                    style: titleStyle,
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    // controller: _controller,
                                    itemCount: specialities.data.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Checkbox(
                                              value: _isChecked[index],
                                              onChanged: (s) {
                                                setState(() {
                                                  _isChecked[index] = s!;
                                                });
                                              }),
                                          Text(specialities
                                              .data[index].specialistName)
                                        ],
                                      );
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Gender',
                                    style: titleStyle,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: Gender.male,
                                        groupValue: gender,
                                        onChanged: (Gender? d) {
                                          setState(() {
                                            gender = d!;
                                          });
                                        }),
                                    Text('Male')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: Gender.female,
                                        groupValue: gender,
                                        onChanged: (Gender? d) {
                                          setState(() {
                                            gender = d!;
                                            print(d);
                                          });
                                        }),
                                    Text('Female')
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Day', style: titleStyle),
                                ),
                                Row(
                                  children: [
                                    Checkbox(value: false, onChanged: (s) {}),
                                    Text('Any Day')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(value: false, onChanged: (s) {}),
                                    Text('Today')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(value: false, onChanged: (s) {}),
                                    Text('Next 3 days')
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Consultancy Fees',
                                      style: titleStyle),
                                ),
                                RangeSlider(
                                  activeColor: apptealColor,
                                  values: currentRangeValues,
                                  min: 0,
                                  max: 100,
                                  //divisions: 5,
                                  labels: RangeLabels(
                                    currentRangeValues.start.round().toString(),
                                    currentRangeValues.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      currentRangeValues = values;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Years Of Experience',
                                      style: titleStyle),
                                ),
                                Slider(
                                  activeColor: apptealColor,
                                  inactiveColor: apptealColor,
                                  thumbColor: Colors.white,
                                  onChanged: (double value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  },
                                  value: _value,
                                  //
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text('Video Consult', style: titleStyle),
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 1,
                                        groupValue: 1,
                                        onChanged: (d) {}),
                                    Text('Yes')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 1,
                                        groupValue: 1,
                                        onChanged: (d) {}),
                                    Text('No')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                });
          },
          backgroundColor: apptealColor,
          child: Icon(
            FontAwesomeIcons.filter,
            color: Colors.white,
          ),
        ),
      ),
      drawer: commonDrawer(),
      appBar: AppBar(
        title: commonAppBarTitle(),
        leading: (widget.fromhome)
            ? commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Pop(context);
                })
            : commonAppBarLeading(
                iconData: Icons.menu,
                onPressed: () {
                  setState(() {
                    Scaffold.of(context).openDrawer();
                  });
                }),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
      body: (_con.loading)
          ? Center(
              child: CircularProgressIndicator(
                color: apptealColor,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Push(context, SearchScreen());
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Color(0xff161616).withOpacity(0.6),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Enter Doctor name, specialty, symptom',
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Color(0xff161616).withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                (widget.isSpecial)
                    ? Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _doctordata.data.length,
                            itemBuilder: (context, index) {
                              var Docs = _doctordata.data[index];
                              return
                                  // (index != 1)
                                  //   ? Container()
                                  //   :
                                  (_doctordata.data[index].specialistId ==
                                          widget.speciality_id)
                                      ? Padding(
                                          padding: (index + 1 ==
                                                  _doctordata.data.length)
                                              ? EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: navbarht + 20,
                                                  top: 10)
                                              : const EdgeInsets.all(5.0),
                                          child: Container(
                                            height: 190,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 10,
                                                  offset: const Offset(2, 5),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 150,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(Docs
                                                                  .profileImage),
                                                          radius: 50,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  Docs.firstName
                                                                          .toString() +
                                                                      ' ' +
                                                                      Docs.lastName
                                                                          .toString(),
                                                                  style:
                                                                      KHeader),
                                                              Text(
                                                                  Docs.specialist
                                                                      .toString(),
                                                                  style: GoogleFonts.montserrat(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12)),
                                                              rowTextIcon(
                                                                text: Docs
                                                                        .experience +
                                                                    ' yrs of exp. overall',
                                                                asset:
                                                                    'assets/pngs/Group.png',
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        rowTextIcon(
                                                                      text: Docs
                                                                          .location,
                                                                      asset:
                                                                          'assets/pngs/Group 1182.png',
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        rowTextIcon(
                                                                      text: '',
                                                                      asset:
                                                                          'assets/pngs/Icon awesome-thumbs-up.png',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        rowTextIcon(
                                                                      text: Docs
                                                                          .available,
                                                                      asset:
                                                                          'assets/pngs/Path 2062.png',
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        rowTextIcon(
                                                                      text: '',
                                                                      asset:
                                                                          'assets/pngs/Icon awesome-star.png',
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
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
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    appblueColor),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15)),
                                                        ))),
                                                    onPressed: () {
                                                      Push(
                                                          context,
                                                          DoctorProfile1(
                                                            doc_id: Docs.userId,
                                                          ));
                                                    },
                                                    child: Text(
                                                      'View Details',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container();
                            }),
                      )
                    : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _doctordata.data.length,
                            itemBuilder: (context, index) {
                              var Docs = _doctordata.data[index];
                              return
                                  // (index != 1)
                                  //   ? Container()
                                  //   :
                                  Padding(
                                padding: (index + 1 == _doctordata.data.length)
                                    ? EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: navbarht + 20,
                                        top: 10)
                                    : const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 190,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 150,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    Docs.profileImage),
                                                radius: 50,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        Docs.firstName
                                                                .toString() +
                                                            ' ' +
                                                            Docs.lastName
                                                                .toString(),
                                                        style: KHeader),
                                                    Text(
                                                        Docs.specialist
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color:
                                                                    Colors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12)),
                                                    rowTextIcon(
                                                      text: Docs.experience +
                                                          ' yrs of exp. overall',
                                                      asset:
                                                          'assets/pngs/Group.png',
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: rowTextIcon(
                                                            text: Docs.location,
                                                            asset:
                                                                'assets/pngs/Group 1182.png',
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: rowTextIcon(
                                                            text: '',
                                                            asset:
                                                                'assets/pngs/Icon awesome-thumbs-up.png',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: rowTextIcon(
                                                            text:
                                                                Docs.available,
                                                            asset:
                                                                'assets/pngs/Path 2062.png',
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: rowTextIcon(
                                                            text: '',
                                                            asset:
                                                                'assets/pngs/Icon awesome-star.png',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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
                                                  MaterialStateProperty.all<
                                                      Color>(appblueColor),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15)),
                                              ))),
                                          onPressed: () {
                                            Push(
                                                context,
                                                DoctorProfile1(
                                                  doc_id: Docs.userId,
                                                ));
                                          },
                                          child: Text(
                                            'View Details',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Colors.white,
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
                      ),
              ],
            ),
    );
  }
}
