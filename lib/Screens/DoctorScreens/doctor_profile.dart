import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/doctor_profile_model.dart';
import 'package:patient/Screens/filter_screen.dart';
import 'package:patient/Screens/search_screen.dart';

import 'package:patient/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/DoctorProdileController/doctor_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
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

class _DoctorProfileState extends State<DoctorProfile> {
  DoctorController _con = DoctorController();

  late DoctorProfileModel _doctordata;

  @override
  void initState() {
    // TODO: implement initState
    _con.getDoctor(context).then((value) {
      setState(() {
        _doctordata = value;
        _con.loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: (widget.fromhome)
            ? EdgeInsets.only(bottom: 0)
            : EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () {
            Push(context, FilterScreen());
          },
          backgroundColor: apptealColor,
          child: Icon(
            FontAwesomeIcons.filter,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        title: commonAppBarTitle(),
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
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
                                  (_doctordata.data[index].specialist_id ==
                                          widget.speciality_id)
                                      ? Padding(
                                          padding: (index + 1 ==
                                                  _doctordata.data.length)
                                              ? EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 50,
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
                                                )
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
                                        bottom: 50,
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
