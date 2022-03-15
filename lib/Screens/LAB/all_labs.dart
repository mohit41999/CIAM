import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/doctor_profile_model.dart';
import 'package:patient/Models/home_doctor_speciality_model.dart';
import 'package:patient/Screens/LAB/lab_details.dart';
import 'package:patient/Screens/search_screen.dart';

import 'package:patient/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/controller/LabController/lab_profile_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/DoctorProfileController/doctor_controller.dart';
import 'package:patient/controller/home_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:patient/widgets/row_text_icon.dart';

class AllLabs extends StatefulWidget {
  @override
  _AllLabsState createState() => _AllLabsState();
}

class _AllLabsState extends State<AllLabs> {
  LABProfileController _controller = LABProfileController();
  Future initialize() async {
    _controller.allLabs = await _controller.getallLabs();
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.allLabs.data.length,
                itemBuilder: (context, index) {
                  return
                      // (index != 1)
                      //   ? Container()
                      //   :
                      Padding(
                    padding: (index + 1 == _controller.allLabs.data.length)
                        ? EdgeInsets.only(
                            left: 10, right: 10, bottom: navbarht + 20, top: 10)
                        : const EdgeInsets.all(5.0),
                    child: Container(
                      height: 150,
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
                            height: 110,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        _controller.allLabs.data[index].image),
                                    radius: 50,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            _controller
                                                .allLabs.data[index].labname,
                                            style: KHeader),
                                        Text(
                                            _controller
                                                .allLabs.data[index].location,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
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
                                          appblueColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ))),
                              onPressed: () {
                                Push(
                                    context,
                                    LabDetails(
                                        labid: _controller
                                            .allLabs.data[index].labId));
                              },
                              child: Text(
                                'View Lab',
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
