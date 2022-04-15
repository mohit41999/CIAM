import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/doctor_profile_model.dart';
import 'package:patient/Models/home_doctor_speciality_model.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_1.dart';
import 'package:patient/Screens/search_screen.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/DoctorProfileController/doctor_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/home_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:patient/widgets/row_text_icon.dart';

class DoctorCategories extends StatefulWidget {
  const DoctorCategories({
    Key? key,
  }) : super(key: key);

  @override
  _DoctorCategoriesState createState() => _DoctorCategoriesState();
}

class _DoctorCategoriesState extends State<DoctorCategories> {
  late HomeDoctorSpecialityModel specialities;
  HomeController _con = HomeController();
  void initialize() {
    _con.getDoctorSpecilities(context).then((value) {
      setState(() {
        specialities = value;
        _con.specialitybool = false;
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
        drawer: commonDrawer(),
        appBar: AppBar(
          title: commonAppBarTitle(),
          leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.menu,
                onPressed: () {
                  setState(() {
                    Scaffold.of(context).openDrawer();
                  });
                }),
          ),
          centerTitle: true,
          backgroundColor: appAppBarColor,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              commonBtn(
                  borderRadius: 5,
                  height: 40,
                  textSize: 14,
                  s: 'Doctor Categories',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {}),
              (_con.specialitybool)
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: specialities.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: (index + 1 == specialities.data.length)
                                  ? EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 8,
                                      bottom: navbarht + 20)
                                  : EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Push(
                                      context,
                                      DoctorProfile(
                                        fromhome: true,
                                        isSpecial: true,
                                        speciality_id: specialities
                                            .data[index].specialistId,
                                      ));
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              specialities
                                                  .data[index].specialistImg),
                                          radius: 40,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              specialities
                                                  .data[index].specialistName,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
            ],
          ),
        ));
  }
}
