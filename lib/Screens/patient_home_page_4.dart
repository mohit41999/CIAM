import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/home_care_categories_model.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_3.dart';
import 'package:patient/Screens/HomeCareCategories.dart';
import 'package:patient/Screens/contact_us_form.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/common_row.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:patient/widgets/patient_home_page_4_alert_box.dart';
import 'package:patient/widgets/tag_line.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientHomePage4 extends StatefulWidget {
  const PatientHomePage4({Key? key}) : super(key: key);

  @override
  _PatientHomePage4State createState() => _PatientHomePage4State();
}

class _PatientHomePage4State extends State<PatientHomePage4> {
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
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                    height: 200,
                    color: Colors.white,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
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
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Heal At Home',
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
                                          s: 'Book Now',
                                          bgcolor: appblueColor,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            // Push(context, DoctorProfile1());
                                            patientpg4alertbox(context,
                                                careController: care,
                                                addressController: address,
                                                emailController: email,
                                                nameController: name,
                                                phonenumberController:
                                                    phonenumber);
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
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 320,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: commonRow(
                            Title: 'Health Care Services',
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    // maxCrossAxisExtent: 100,
                                    childAspectRatio: 3 / 4,
                                    // crossAxisSpacing: 10,
                                    // mainAxisSpacing: 10,
                                    crossAxisCount: 2),
                            itemCount: homeCareCategories.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Push(
                                        context,
                                        DoctorProfile3(
                                          cat_id: homeCareCategories
                                              .data[index].serviceId,
                                          cat_name: homeCareCategories
                                              .data[index].serviceName,
                                        ));
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
                                            backgroundImage: NetworkImage(
                                              homeCareCategories
                                                  .data[index].image,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                homeCareCategories
                                                    .data[index].serviceName,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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
}
