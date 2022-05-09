import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/home_care_categories_model.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_3.dart';
import 'package:patient/Screens/contact_us_form.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
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
        centerTitle: false,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
        elevation: 0,
        titleSpacing: 0,
        leading: Builder(
          builder: (context) => commonAppBarLeading(
              iconData: Icons.arrow_back_ios_new,
              onPressed: () {
                setState(() {
                  Pop(context);
                });
              }),
        ),
      ),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: homeCareCategories.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: (index + 1 == homeCareCategories.data.length)
                              ? EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  bottom: navbarht + 20,
                                  top: 10)
                              : const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                                homeCareCategories
                                                    .data[index].image),
                                            radius: 50,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                                homeCareCategories
                                                    .data[index].serviceName,
                                                style: KHeader),
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
                                                bottomRight:
                                                    Radius.circular(15)),
                                          ))),
                                      onPressed: () {
                                        Push(
                                            context,
                                            DoctorProfile3(
                                              cat_id: homeCareCategories
                                                  .data[index].serviceId,
                                              cat_name: homeCareCategories
                                                  .data[index].serviceName,
                                            ));
                                      },
                                      child: Text(
                                        'View ',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Colors.white,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
