import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/home_care_categories_model.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_1.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_3.dart';
import 'package:patient/Screens/LabProfile.dart';
import 'package:patient/Screens/MedicineProfile.dart';
import 'package:patient/Screens/Products.dart';
import 'package:patient/Screens/Signup.dart';
import 'package:patient/Screens/patient_home_page_4.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/navigation_drawer.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/common_row.dart';
import 'package:patient/widgets/patient_home_page_4_alert_box.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeCareCategories extends StatefulWidget {
  const HomeCareCategories({Key? key}) : super(key: key);

  @override
  _HomeCareCategoriesState createState() => _HomeCareCategoriesState();
}

class _HomeCareCategoriesState extends State<HomeCareCategories> {
  Future<HealthCareCategoriesModel> gethomecareServices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response = await PostData(
        PARAM_URL: 'get_home_care_services.php',
        params: {'user_id': preferences.getString('user_id'), 'token': Token});

    return HealthCareCategoriesModel.fromJson(response);
  }

  TextEditingController care = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  late HealthCareCategoriesModel homeCareCategories;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gethomecareServices().then((value) {
      setState(() {
        homeCareCategories = value;
        loading = false;
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
                    Icons.arrow_back_ios_new,
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
                  Pop(context);
                });
              },
            ),
          ),
        ),
      ),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: homeCareCategories.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: (index + 1 == 10)
                            ? EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: navbarht + 20,
                                top: 10)
                            : const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Push(
                                context,
                                DoctorProfile3(
                                  cat_id:
                                      homeCareCategories.data[index].serviceId,
                                  cat_name: homeCareCategories
                                      .data[index].serviceName,
                                ));
                          },
                          child: Container(
                            height: 126,
                            width: 154,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(2, 5),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  homeCareCategories.data[index].image,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      homeCareCategories
                                          .data[index].serviceName,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
    );
  }
}
