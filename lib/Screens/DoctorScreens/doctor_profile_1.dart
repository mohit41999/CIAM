import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:patient/Models/doctor_profile_one_model.dart';
import 'package:patient/Models/slot_time_model.dart';
import 'package:patient/Screens/booking_appointment.dart';
import 'package:patient/Utils/colorsandstyles.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:patient/controller/DoctorProdileController/doctor_profile_one_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/doctor_profile_row.dart';
import 'package:patient/widgets/enter_field.dart';

class DoctorProfile1 extends StatefulWidget {
  final String doc_id;
  const DoctorProfile1({Key? key, required this.doc_id}) : super(key: key);

  @override
  _DoctorProfile1State createState() => _DoctorProfile1State();
}

class _DoctorProfile1State extends State<DoctorProfile1> {
  DoctorProfileOneController _con = DoctorProfileOneController();
  late DoctorProfileOneModel doctordetails;
  late SlotTime slot_time;
  int _selectedindex = -1;
  String selectedTime = '';
  DateTime date = DateTime.now();

  Color textColor = Color(0xff161616);
  TextEditingController _controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 7),
      builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            dialogBackgroundColor: appblueColor,
            colorScheme: ColorScheme.dark(
                primary: Colors.white,
                surface: appblueColor,
                onSurface: Colors.white,
                onPrimary: appblueColor),
          ),
          child: child!),
    );
    if (pickedDate != null)
      setState(() {
        date = pickedDate;

        print(date);
      });
  }

  Future initializeSlots() async {
    _con
        .getSlotTime(
            context, widget.doc_id, '${date.year}-${date.month}-${date.day}')
        .then((value) {
      setState(() {
        slot_time = value;
        _con.loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _con.getDoctorDetails(context, widget.doc_id).then((value) {
      setState(() {
        doctordetails = value;
        initializeSlots();
      });
    });
    // print(slot_time.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (_con.loading)
              ? Center(
                  child: CircularProgressIndicator(
                    color: apptealColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 260,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/pngs/Rectangle 69.png'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: Text(
                            doctordetails.data.doctorDetails.doctorName,
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: appblueColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 325,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Details',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                color: textColor.withOpacity(0.4),
                                thickness: 1,
                              ),
                              doctorProfileRow(
                                title: 'Specialty',
                                value:
                                    doctordetails.data.doctorDetails.specialist,
                              ),
                              doctorProfileRow(
                                title: 'Education Details',
                                value:
                                    doctordetails.data.doctorDetails.education,
                              ),
                              doctorProfileRow(
                                title: 'Language Spoken',
                                value: doctordetails
                                    .data.doctorDetails.languageSpoken,
                              ),
                              doctorProfileRow(
                                title: 'Experience',
                                value:
                                    doctordetails.data.doctorDetails.experience,
                              ),
                              doctorProfileRow(
                                title: 'About Me',
                                value:
                                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 468,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Clinic Info',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                color: textColor.withOpacity(0.4),
                                thickness: 1,
                              ),
                              doctorProfileRow(
                                title: 'Clinic Name',
                                value:
                                    doctordetails.data.clinicDetails.clinicName,
                              ),
                              doctorProfileRow(
                                title: 'Location of clinic',
                                value:
                                    doctordetails.data.clinicDetails.location,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child: Text(
                                      'Uploaded Images',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Color(0xff161616)
                                              .withOpacity(0.6)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('-'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width /
                                          1.65,
                                      child: ListView.builder(
                                          itemCount: 5,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/pngs/doctorprofile.png',
                                                      ),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            );
                                          }))
                                ],
                              ),
                              doctorProfileRow(
                                title: 'From to To Days',
                                value:
                                    doctordetails.data.clinicDetails.fromToDays,
                              ),
                              doctorProfileRow(
                                title: 'Open-Close Time',
                                value: doctordetails
                                    .data.clinicDetails.openCloseTime,
                              ),
                              doctorProfileRow(
                                title: 'Offline Consultancy Fees',
                                value: doctordetails
                                    .data.clinicDetails.oflineConsultancyFees,
                              ),
                              doctorProfileRow(
                                title: 'Doctor’s availability status',
                                value: doctordetails.data.clinicDetails
                                    .doctorAvailabilityStatus,
                                yellow: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                          color: Colors.white,
                          height: 329,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3.0),
                                  child: Text(
                                    'Ratings',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Divider(
                                  color: textColor.withOpacity(0.4),
                                  thickness: 1,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 5,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 8),
                                        child: Card(
                                          elevation: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                leading: CircleAvatar(
                                                  radius: 30,
                                                ),
                                                title: Text('Username'),
                                                subtitle: Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        size: 14,
                                                        color: apptealColor),
                                                    Icon(
                                                      Icons.star,
                                                      size: 14,
                                                      color: apptealColor,
                                                    ),
                                                    Icon(Icons.star,
                                                        size: 14,
                                                        color: apptealColor),
                                                    Icon(Icons.star,
                                                        size: 14,
                                                        color: apptealColor),
                                                    Icon(Icons.star,
                                                        size: 14,
                                                        color: apptealColor),
                                                  ],
                                                ),
                                                trailing: Text(
                                                  '27/09/2021',
                                                  style: GoogleFonts.lato(
                                                      color: apptealColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: Text(
                                                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea.',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 755,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Schedule Video Consultancy Appointment',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                color: textColor.withOpacity(0.4),
                                thickness: 1,
                              ),
                              doctorProfileRow(
                                title: 'Doctor\'s Availability Status',
                                value: 'Available',
                                yellow: true,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child: Text(
                                      'Price per slot',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Color(0xff161616)
                                              .withOpacity(0.6)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('-'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width /
                                          1.65,
                                      child: ListView.builder(
                                          itemCount: 5,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Container(
                                                width: 92,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffF6F6F6),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        '9:00-9:30\nAM',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Divider(
                                                        height: 5,
                                                        thickness: 1,
                                                        color: Color(0xff161616)
                                                            .withOpacity(0.2),
                                                      ),
                                                      Text('\$59',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  color:
                                                                      apptealColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }))
                                ],
                              ),
                              Container(
                                height: 44,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: Icon(
                                    //       Icons.arrow_back_ios_new,
                                    //       size: 18,
                                    //       color: apptealColor,
                                    //     )),
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${date.day}-${date.month}-${date.year.toString().substring(2, 4)}",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${slot_time.data.timeSlot.length} Slots',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: commonBtn(
                                        height: 50,
                                        borderWidth: 2,
                                        textSize: 12,
                                        s: 'Select Date',
                                        bgcolor: Colors.white,
                                        textColor: appblueColor,
                                        onPressed: () {
                                          _selectDate(context).then((value) {
                                            setState(() {
                                              initializeSlots();
                                            });
                                          });
                                        },
                                        borderRadius: 10,
                                        borderColor: appblueColor,
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       _selectDate(context).then((value) {
                                    //         setState(() {
                                    //           initializeSlots();
                                    //         });
                                    //       });
                                    //     },
                                    //     child: Center(
                                    //       child: Text(
                                    //         'Select Date',
                                    //         style: GoogleFonts.montserrat(
                                    //             color: appblueColor,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: 15),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: Icon(
                                    //       Icons.arrow_forward_ios,
                                    //       size: 18,
                                    //       color: apptealColor,
                                    //     )),
                                  ],
                                ),
                              ),
                              Divider(
                                color: textColor.withOpacity(0.4),
                                thickness: 1,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Slots(
                                      text: 'Morning',
                                      startTime: 0,
                                      endTime: 12,
                                      time: ' am'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Slots(
                                      text: 'Afternoon',
                                      startTime: 12,
                                      endTime: 17,
                                      time: ' pm'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Slots(
                                      text: 'Evening',
                                      startTime: 17,
                                      endTime: 24,
                                      time: ' pm'),
                                ],
                              ),
                              Text(
                                'Enter Comments',
                                style: GoogleFonts.montserrat(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              EnterField(
                                'Enter Comments',
                                'Enter Comments',
                                _controller,
                              ),
                              Text(
                                'Upload Report File',
                                style: GoogleFonts.montserrat(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              commonBtn(
                                s: 'Choose report',
                                height: 40,
                                textSize: 14,
                                bgcolor: Color(0xff161616).withOpacity(0.3),
                                textColor: Color(0xff161616),
                                onPressed: () {},
                                borderRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: commonBtn(
                            s: 'Book an Appointment',
                            bgcolor: appblueColor,
                            textColor: Colors.white,
                            borderRadius: 8,
                            onPressed: () {
                              _con.add_booking_request(
                                  context,
                                  widget.doc_id,
                                  '${date.year}-${date.month}-${date.day}',
                                  selectedTime);
                            }),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column Slots(
      {required String text,
      required int startTime,
      required int endTime,
      required String time}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.montserrat(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   color: apptealColor,
            //   size: 20,
            // ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 34,
          child: ListView.builder(
            itemBuilder: (context, index) {
              print(slot_time.data.timeSlot[index].slotTime);
              int am = (slot_time.data.timeSlot[index].slotTime.toString() ==
                      null.toString())
                  ? 0
                  : int.parse(
                      slot_time.data.timeSlot[index].slotTime.substring(0, 2));
              return (am == 0)
                  ? Container()
                  : (am >= startTime && am < endTime)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: commonBtn(
                            s: slot_time.data.timeSlot[index].slotTime
                                    .substring(0, 5)
                                    .toString() +
                                time,
                            bgcolor: slot_time.data.timeSlot[index].status ==
                                    'availiable'
                                ? (_selectedindex == index)
                                    ? apptealColor
                                    : Colors.white
                                : Colors.white,
                            textColor: slot_time.data.timeSlot[index].status ==
                                    'availiable'
                                ? (_selectedindex == index)
                                    ? Colors.white
                                    : apptealColor
                                : Colors.grey,
                            onPressed: () {
                              setState(() {
                                _selectedindex = index;
                                selectedTime = slot_time
                                            .data.timeSlot[index].status ==
                                        'availiable'
                                    ? slot_time.data.timeSlot[index].slotTime
                                    : '';
                                print(selectedTime + '${_selectedindex}');
                              });
                            },
                            textSize: 12,
                            width: 100,
                            borderRadius: 0,
                            borderWidth: 1,
                            borderColor:
                                slot_time.data.timeSlot[index].status ==
                                        'availiable'
                                    ? apptealColor
                                    : Colors.grey,
                          ),
                        )
                      : Container();
            },
            itemCount: slot_time.data.timeSlot.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
