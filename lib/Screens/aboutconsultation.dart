import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/doctor_profile_model.dart';
import 'package:patient/Models/home_doctor_speciality_model.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile.dart';
import 'package:patient/Screens/DoctorScreens/doctor_profile_1.dart';
import 'package:patient/Screens/LabProfile.dart';
import 'package:patient/Screens/MedicineProfile.dart';
import 'package:patient/Screens/Products.dart';
import 'package:patient/Screens/patient_home_page_4.dart';
import 'package:patient/Screens/search_screen.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/DoctorProdileController/doctor_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/about_consultation_controller.dart';
import 'package:patient/controller/home_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/common_row.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:patient/widgets/row_text_icon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    'Screen': DoctorProfile(
      fromhome: true,
    ),
    'profile': 'Rectangle 69.png'
  },
  {
    'label': 'Health care & Other product',
    // 'Screen': 'null',
    'Screen': ProductPage(),
    'profile': 'Rectangle -7.png'
  },
  {
    'label': 'Home Care Servicies',
    // 'Screen': 'null',
    'Screen': PatientHomePage4(),
    'profile': 'Rectangle -1.png'
  },
  {
    'label': 'Stress buster zone',
    'Screen': 'null',
    'profile': 'Rectangle -6.png'
  },
  {
    'label': 'Lab Tests',
    // 'Screen': 'null',
    'Screen': LabProfile(),
    'profile': 'Rectangle -2.png'
  },
  {'label': 'Ask Questions', 'Screen': 'null', 'profile': 'Rectangle 69.png'},
  {
    'label': 'Medicine',
    // 'Screen': 'null',
    'Screen': MedicineProfile(),
    'profile': 'Rectangle 69.png'
  },
  {'label': 'Knowledge Forum', 'Screen': 'null', 'profile': 'Rectangle -4.png'},
];

class AboutConsultation extends StatefulWidget {
  const AboutConsultation({Key? key}) : super(key: key);

  @override
  _AboutConsultationState createState() => _AboutConsultationState();
}

class _AboutConsultationState extends State<AboutConsultation> {
  AboutConsultationController _con = AboutConsultationController();
  DoctorController _doctorControllercon = DoctorController();
  late HomeDoctorSpecialityModel specialities;
  int _current = 0;
  late Position position;
  final CarouselController _controller = CarouselController();
  final CarouselController _reviewcontroller = CarouselController();

  late DoctorProfileModel _doctordata;
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    _doctorControllercon.getDoctor(context).then((value) {
      setState(() {
        _doctordata = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: commonAppBarTitle(),
          backgroundColor: Colors.white,
          elevation: 0,
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
            SizedBox(
              height: 10,
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
                height: 280,
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
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.25,
                              ),
                              Text(
                                'Experienced \nDoctor',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(),
                              )
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.25,
                              ),
                              Text(
                                '3 day chat option to ask query',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(),
                              )
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.25,
                              ),
                              Text(
                                '3 day chat option to ask query',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(),
                              )
                            ],
                          )),
                        ],
                      ),
                      commonBtn(
                          s: 'Consult Now',
                          bgcolor: appblueColor,
                          textColor: Colors.white,
                          borderRadius: 10,
                          onPressed: () {
                            Push(context, DoctorProfile(fromhome: true));
                          })
                    ],
                  ),
                )),
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
                    child: Text(
                      'Why Consult on our App?',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: appblueColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/pngs/Rectangle 69.png'))),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '250+',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('Quality Doctors',
                                style: GoogleFonts.montserrat()),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/pngs/Rectangle 69.png'))),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '500+',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('Satisfied Customer',
                                style: GoogleFonts.montserrat()),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/pngs/Rectangle 69.png'))),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '200+',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('Super Specialists',
                                style: GoogleFonts.montserrat()),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/pngs/Rectangle 69.png'))),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '250+',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('Secure and Private',
                                style: GoogleFonts.montserrat()),
                          ],
                        )
                      ],
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
                    child: (loading)
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
              height: 15,
            ),
            Container(
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
                        children: hometile.asMap().entries.map((entry) {
                          return GestureDetector(
                              onTap: () =>
                                  _reviewcontroller.animateToPage(entry.key),
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
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Frequently Asked Questions',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: appblueColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 250,
                    child: ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: Text('Question' + index.toString()),
                            children: [
                              Text(
                                'This is Answer' + index.toString(),
                                textAlign: TextAlign.start,
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }

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

  List<Widget> Review(BuildContext context) => hometile
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
                    title: Text(''),
                    subtitle: RatingBarIndicator(
                      rating: 4.0,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: apptealColor,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      unratedColor: Colors.grey.withOpacity(0.5),
                      direction: Axis.horizontal,
                    ),
                    //     RatingBar.builder(
                    //   maxRating: 5,
                    //   itemSize: 20,
                    //   minRating: 1,
                    //   unratedColor:
                    //       apptealColor,
                    //   direction:
                    //       Axis.horizontal,
                    //   allowHalfRating: true,
                    //   itemCount: int.parse(
                    //       reviews.data[index]
                    //           .rating),
                    //   itemBuilder:
                    //       (context, _) =>
                    //           Icon(
                    //     Icons.star,
                    //     color: apptealColor,
                    //   ),
                    //   onRatingUpdate:
                    //       (rating) {
                    //     print(rating);
                    //   },
                    // ),
                    // Row(
                    //   children: [
                    //     Icon(Icons.star,
                    //         size: 14,
                    //         color:
                    //             apptealColor),
                    //     Icon(
                    //       Icons.star,
                    //       size: 14,
                    //       color: apptealColor,
                    //     ),
                    //     Icon(Icons.star,
                    //         size: 14,
                    //         color:
                    //             apptealColor),
                    //     Icon(Icons.star,
                    //         size: 14,
                    //         color:
                    //             apptealColor),
                    //     Icon(Icons.star,
                    //         size: 14,
                    //         color:
                    //             apptealColor),
                    //   ],
                    // ),
                    trailing: Text(
                      '15-02-2022',
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
                      'Excellent Treatments and Consultation',
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
}
