import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/doctor_profile_model.dart';
import 'package:patient/Models/home_care_categories_model.dart';
import 'package:patient/Models/home_doctor_speciality_model.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_1.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_3.dart';
import 'package:patient/Screens/HomeCareCategories.dart';
import 'package:patient/Screens/LAB/lab_profile.dart';
import 'package:patient/Screens/MYScreens/MyQuestionsScreen.dart';
import 'package:patient/Screens/aboutconsultation.dart';
import 'package:patient/Screens/contact_us_form.dart';
import 'package:patient/Screens/doctor_categories.dart';
import 'package:patient/Screens/hospital_packages.dart';
import 'package:patient/Screens/knowledge_forum_screen.dart';
import 'package:patient/Screens/patient_home_page_4.dart';
import 'package:patient/Screens/search_screen.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/DoctorProfileController/doctor_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/home_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/common_row.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:patient/widgets/row_text_icon.dart';
import 'package:patient/widgets/tag_line.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
final List<Map<dynamic, dynamic>> hometile = [
  {
    'label': 'Doctor Consultation',
    'Screen': AboutConsultation(),
    'profile': 'Rectangle 69.png'
  },
  // {
  //   'label': 'Health care & Other product',
  //   // 'Screen': 'null',
  //   'Screen': ProductPage(),
  //   'profile': 'Rectangle -7.png'
  // },
  {
    'label': 'Home Care Servicies',
    // 'Screen': 'null',
    'Screen': PatientHomePage4(),
    'profile': 'Rectangle -1.png'
  },
  // {
  //   'label': 'Stress buster zone',
  //   'Screen': 'null',
  //   'profile': 'Rectangle -6.png'
  // },
  // {
  //   'label': 'Lab Tests',
  //   // 'Screen': 'null',
  //   'Screen': LabProfile(),
  //   'profile': 'Rectangle -2.png'
  // },
  {
    'label': 'Hospital Packages',
    'Screen': HospitalPackages(),
    'profile': 'Rectangle -4.png'
  },
  {
    'label': 'Ask Questions',
    'Screen': MyQuestionsScreen(),
    'profile': 'Rectangle 69.png'
  },
  // {
  //   'label': 'Medicine',
  //   // 'Screen': 'null',
  //   'Screen': MedicineProfile(),
  //   'profile': 'Rectangle 69.png'
  // },
  {
    'label': 'Knowledge Forum',
    'Screen': KnowledgeForumScreen(),
    'profile': 'Rectangle -4.png'
  },
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool healthcareLoading = true;
  late HealthCareCategoriesModel healthCareCategories;

  bool doctorloading = true;
  Future<HealthCareCategoriesModel> gethomecareServices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var response = await PostData(
        PARAM_URL: 'get_home_care_services.php',
        params: {'user_id': preferences.getString('user_id'), 'token': Token});

    return HealthCareCategoriesModel.fromJson(response);
  }

  HomeController _con = HomeController();
  late HomeDoctorSpecialityModel specialities;
  int _current = 0;
  late Position position;
  DoctorController _doctorControllercon = DoctorController();
  late DoctorProfileModel _doctordata;
  final CarouselController _controller = CarouselController();

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
  TextEditingController _search = TextEditingController();
  List<Placemark> address = [];
  Future getcity() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print(placemarks);
      setState(() {
        address = placemarks;
        preferences.setString('city', address[0].subAdministrativeArea!);
      });
    } catch (err) {}
  }

  void initialize() {
    _con.determinePosition().then((value) {
      setState(() {
        position = value;
        getcity();
        print(position);
      });
    });
    _con.getDoctorSpecilities(context).then((value) {
      setState(() {
        specialities = value;
        _con.specialitybool = false;
      });
    });
    gethomecareServices().then((value) {
      setState(() {
        healthCareCategories = value;
        healthcareLoading = false;
      });
    });
    _doctorControllercon.getDoctor(context).then((value) {
      setState(() {
        doctorloading = false;
        _doctordata = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: commonAppBarTitle(),
          backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: commonBtn(
                    height: 46,
                    textSize: 12,
                    s: (address.length == 0)
                        ? ''
                        : address[0].administrativeArea! +
                            ' ' +
                            address[0].subAdministrativeArea!,
                    bgcolor: Colors.white,
                    borderRadius: 5,
                    borderColor: appblueColor,
                    borderWidth: 2,
                    textColor: apptealColor,
                    onPressed: () {}),
              ),
            ),
            GestureDetector(
              onTap: () {
                Push(context, SearchScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
                        width: 15,
                      ),
                      Text(
                        'Search',
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Color(0xff161616).withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
              color: Colors.white,
              width: double.infinity,
              height: 302,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // maxCrossAxisExtent: 100,
                          // childAspectRatio: 1.45 / 1,
                          childAspectRatio: 0.9,
                          // crossAxisSpacing: 10,
                          // mainAxisSpacing: 10,
                          crossAxisCount: 3),
                      itemCount: hometile.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              (hometile[index]['Screen'].toString() == 'null')
                                  ? {print('blablabla')}
                                  : Push(context, hometile[index]['Screen']);
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: appblueColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.asset(
                                      'assets/pngs/${hometile[index]['profile']}'),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      hometile[index]['label'].toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              ],
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
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: commonRow(
                      Title: 'Meet our Doctors',
                      subTitle: 'View all',
                      value: DoctorProfile(fromhome: true),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.only(
                    //       bottomLeft: Radius.circular(15),
                    //       bottomRight: Radius.circular(15)),
                    // ),
                    child: (doctorloading)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              var Docs = _doctordata.data[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 15),
                                child: Container(
                                  height: 190,
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
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
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: commonRow(
                      subTitle: 'View all',
                      Title: 'Find Your Doctors',
                      value: DoctorCategories(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Choose from top specialities',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: apptealColor),
                    ),
                  ),
                  Container(
                    height: 150,
                    child: (_con.specialitybool)
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: specialities.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            specialities
                                                .data[index].specialistImg),
                                        radius: 50,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        specialities.data[index].specialistName,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
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
                    height: 150,
                    //color: Colors.red,
                    child: (healthcareLoading)
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    // maxCrossAxisExtent: 100,
                                    childAspectRatio: 3 / 4,
                                    // crossAxisSpacing: 10,
                                    // mainAxisSpacing: 10,
                                    crossAxisCount: 1),
                            itemCount: healthCareCategories.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Push(
                                        context,
                                        DoctorProfile3(
                                          cat_id: healthCareCategories
                                              .data[index].serviceId,
                                          cat_name: healthCareCategories
                                              .data[index].serviceName,
                                          fromHome: true,
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
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              healthCareCategories
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
                                                healthCareCategories
                                                    .data[index].serviceName,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
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

            SizedBox(
              height: 15,
            ),

            // Container(
            //   color: Colors.white,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: commonRow(
            //           Title: 'Health Checkup at Home',
            //           subTitle: 'View all',
            //           value: DoctorProfile(fromhome: true),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 150,
            //         //color: Colors.red,
            //         child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: 5,
            //             itemBuilder: (context, index) {
            //               return Padding(
            //                 padding: const EdgeInsets.all(15.0),
            //                 child: Container(
            //                   height: 126,
            //                   width: 154,
            //                   decoration: BoxDecoration(
            //                     color: Colors.black,
            //                     borderRadius: BorderRadius.circular(10),
            //                     boxShadow: [
            //                       BoxShadow(
            //                         color: Colors.grey.withOpacity(0.5),
            //                         blurRadius: 10,
            //                         offset: const Offset(2, 5),
            //                       ),
            //                     ],
            //                   ),
            //                   child: Stack(
            //                     children: [
            //                       Image.asset(
            //                         'assets/pngs/Icon material-face.png',
            //                         height: double.infinity,
            //                         width: double.infinity,
            //                       ),
            //                       Container(
            //                         height: double.infinity,
            //                         width: double.infinity,
            //                         decoration: BoxDecoration(
            //                           color: Colors.grey.withOpacity(0.2),
            //                           borderRadius: BorderRadius.circular(10),
            //                         ),
            //                         child: Center(
            //                           child: Text(
            //                             'Physiotherapy',
            //                             style: GoogleFonts.montserrat(
            //                                 fontSize: 16,
            //                                 color: Colors.white,
            //                                 fontWeight: FontWeight.bold),
            //                           ),
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             }),
            //       ),
            //     ],
            //   ),
            // ),
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
              height: 15,
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
