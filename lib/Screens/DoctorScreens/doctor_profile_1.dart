import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:patient/Models/doc_review_model.dart';
import 'package:patient/Models/doctor_profile_one_model.dart';
import 'package:patient/Models/relative_model.dart';
import 'package:patient/Models/slot_time_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/DoctorProdileController/doctor_profile_one_controller.dart';
import 'package:patient/controller/ProfileSettingController/relatice_setting_controller.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/doctor_profile_row.dart';

class DoctorProfile1 extends StatefulWidget {
  final String doc_id;
  const DoctorProfile1({Key? key, required this.doc_id}) : super(key: key);

  @override
  _DoctorProfile1State createState() => _DoctorProfile1State();
}

class _DoctorProfile1State extends State<DoctorProfile1> {
  DoctorProfileOneController _con = DoctorProfileOneController();
  late DoctorProfileOneModel doctordetails;
  TextStyle selectedDayStyle(int index) => TextStyle(
      color: (_selectedday == index) ? Colors.black : Colors.grey,
      fontWeight:
          (_selectedday == index) ? FontWeight.bold : FontWeight.normal);

  TextStyle selectedSlotsStyle(int index) => TextStyle(
      color: (_selectedday == index) ? Colors.amber : Colors.grey,
      fontWeight:
          (_selectedday == index) ? FontWeight.bold : FontWeight.normal);
  late DocReviewModel reviews;
  late SlotTime slot_time;
  int _selectedindex = -1;
  int _selectedday = 0;
  String selectedTime = '';
  DateTime date = DateTime.now();
  late RelativeModel relativeData;

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

  Future initialize() async {
    print(date.toString() + '------------------------');
    _con
        .getSlotTime(
            context, widget.doc_id, '${date.year}-${date.month}-${date.day}')
        .then((value) {
      slot_time = value;
      setState(() {
        _con.getRatingsandReview(context, widget.doc_id).then((value) {
          reviews = value;
          setState(() {
            RelativeSettingController().getrelativedata(context).then((value) {
              setState(() {
                relativeData = value;
                relativeData.data.insert(
                    0,
                    RelativeModelData(
                        relative_id: '0',
                        relation: '',
                        relativeName: 'ME',
                        bloodGroup: '',
                        gender: '',
                        age: '',
                        maritalStatus: ''));
                _con.loading = false;
              });
            });
          });
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _con.getDoctorDetails(context, widget.doc_id).then((value) {
      setState(() {
        doctordetails = value;
        initialize();
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
                                image: NetworkImage(doctordetails
                                    .data.doctorDetails.profile_image),
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
                                  value: doctordetails
                                      .data.doctorDetails.about_me),
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
                                          itemCount: doctordetails
                                              .data.clinicImages.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        doctordetails
                                                            .data
                                                            .clinicImages[index]
                                                            .clinicImages,
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
                                title: 'Online Consultancy Fees',
                                value:
                                    "\₹ ${doctordetails.data.clinicDetails.oflineConsultancyFees}",
                              ),
                              // doctorProfileRow(
                              //   title: 'Doctor’s availability status',
                              //   value: doctordetails.data.clinicDetails
                              //       .doctorAvailabilityStatus,
                              //   yellow: true,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                          color: Colors.white,
                          height: (reviews.data.length == 0) ? 110 : 290,
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
                                (reviews.data.length == 0)
                                    ? Center(child: Text('No reviews yet'))
                                    : Expanded(
                                        child: ListView.builder(
                                          itemCount: reviews.data.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 8),
                                              child: Container(
                                                width: 300,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          offset: Offset(2, 2),
                                                          color: Colors.grey
                                                              .withOpacity(0.6),
                                                          spreadRadius: 2,
                                                          blurRadius: 2)
                                                    ]),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ListTile(
                                                      leading: CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage:
                                                            NetworkImage(reviews
                                                                .data[index]
                                                                .userDetails
                                                                .patientImage),
                                                      ),
                                                      title: Text(reviews
                                                          .data[index]
                                                          .userDetails
                                                          .patientName),
                                                      subtitle:
                                                          RatingBarIndicator(
                                                        rating: double.parse(
                                                            reviews.data[index]
                                                                .rating),
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: apptealColor,
                                                        ),
                                                        itemCount: 5,
                                                        itemSize: 20.0,
                                                        unratedColor: Colors
                                                            .grey
                                                            .withOpacity(0.5),
                                                        direction:
                                                            Axis.horizontal,
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
                                                        reviews
                                                            .data[index].date,
                                                        style: GoogleFonts.lato(
                                                            color: apptealColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15.0),
                                                      child: Text(
                                                        reviews.data[index]
                                                            .message,
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
                        height: 400,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Doctor’s Availability',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: textColor.withOpacity(0.4),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Divider(
                              //   color: textColor.withOpacity(0.4),
                              //   thickness: 1,
                              // ),
                              // doctorProfileRow(
                              //   title: 'Doctor\'s Availability Status',
                              //   value: 'Available',
                              //   yellow: true,
                              // ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Container(
                              //       width:
                              //           MediaQuery.of(context).size.width / 5,
                              //       child: Text(
                              //         'Price per slot',
                              //         style: GoogleFonts.montserrat(
                              //             fontSize: 12,
                              //             color: Color(0xff161616)
                              //                 .withOpacity(0.6)),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 15,
                              //     ),
                              //     Text('-'),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Container(
                              //         height: 70,
                              //         width: MediaQuery.of(context).size.width /
                              //             1.65,
                              //         child: ListView.builder(
                              //             itemCount:
                              //                 slot_time.data.timeSlot.length,
                              //             scrollDirection: Axis.horizontal,
                              //             itemBuilder: (context, index) {
                              //               return Padding(
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                         horizontal: 5.0),
                              //                 child: Container(
                              //                   width: 92,
                              //                   decoration: BoxDecoration(
                              //                     color: Color(0xffF6F6F6),
                              //                     borderRadius:
                              //                         BorderRadius.circular(5),
                              //                   ),
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsets.all(5.0),
                              //                     child: Column(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceEvenly,
                              //                       children: [
                              //                         (index ==
                              //                                 slot_time
                              //                                         .data
                              //                                         .timeSlot
                              //                                         .length -
                              //                                     1)
                              //                             ? Text(slot_time
                              //                                 .data
                              //                                 .timeSlot[index]
                              //                                 .slotTime
                              //                                 .toString()
                              //                                 .substring(0, 5))
                              //                             : Text(
                              //                                 slot_time
                              //                                         .data
                              //                                         .timeSlot[
                              //                                             index]
                              //                                         .slotTime
                              //                                         .toString()
                              //                                         .substring(
                              //                                             0,
                              //                                             5) +
                              //                                     '-' +
                              //                                     slot_time
                              //                                         .data
                              //                                         .timeSlot[
                              //                                             index +
                              //                                                 1]
                              //                                         .slotTime
                              //                                         .toString()
                              //                                         .substring(
                              //                                             0, 5),
                              //                                 textAlign:
                              //                                     TextAlign
                              //                                         .center,
                              //                                 style: GoogleFonts.montserrat(
                              //                                     color: Colors
                              //                                         .black,
                              //                                     fontSize: 12,
                              //                                     fontWeight:
                              //                                         FontWeight
                              //                                             .bold),
                              //                               ),
                              //                         Divider(
                              //                           height: 5,
                              //                           thickness: 1,
                              //                           color: Color(0xff161616)
                              //                               .withOpacity(0.2),
                              //                         ),
                              //                         Text(
                              //                             "\₹ " +
                              //                                 doctordetails
                              //                                     .data
                              //                                     .clinicDetails
                              //                                     .oflineConsultancyFees,
                              //                             style: GoogleFonts
                              //                                 .montserrat(
                              //                                     color:
                              //                                         apptealColor,
                              //                                     fontSize: 14,
                              //                                     fontWeight:
                              //                                         FontWeight
                              //                                             .bold))
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               );
                              //             }))
                              //   ],
                              // ),
                              Container(
                                height: 44,
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back_ios_new),
                                    Expanded(
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 7,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  _selectedday = index;
                                                  setState(() {
                                                    date = DateTime(
                                                        DateTime.now().year,
                                                        DateTime.now().month,
                                                        DateTime.now().day +
                                                            index);
                                                    initialize();
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      (index == 0)
                                                          ? Text(
                                                              'Today',
                                                              style:
                                                                  selectedDayStyle(
                                                                      index),
                                                            )
                                                          : (index == 1)
                                                              ? Text(
                                                                  'Tomorrow',
                                                                  style:
                                                                      selectedDayStyle(
                                                                          index),
                                                                )
                                                              : Text(
                                                                  DateFormat('EEEE').format(DateTime(
                                                                      DateTime.now()
                                                                          .year,
                                                                      DateTime.now()
                                                                          .month,
                                                                      DateTime.now()
                                                                              .day +
                                                                          index)),
                                                                  style:
                                                                      selectedDayStyle(
                                                                          index),
                                                                ),
                                                      Text(
                                                        'Slots',
                                                        style:
                                                            selectedSlotsStyle(
                                                                index),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     // IconButton(
                                //     //     onPressed: () {},
                                //     //     icon: Icon(
                                //     //       Icons.arrow_back_ios_new,
                                //     //       size: 18,
                                //     //       color: apptealColor,
                                //     //     )),
                                //     Expanded(
                                //       child: Center(
                                //         child: Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: [
                                //             Text(
                                //               "${date.day}-${date.month}-${date.year.toString().substring(2, 4)}",
                                //               style: GoogleFonts.montserrat(
                                //                   fontSize: 14,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //             SizedBox(
                                //               height: 10,
                                //             ),
                                //             Text(
                                //               '${slot_time.data.timeSlot.length} Slots',
                                //               style: GoogleFonts.montserrat(
                                //                   fontSize: 12,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //     Expanded(
                                //       child: commonBtn(
                                //         height: 50,
                                //         borderWidth: 2,
                                //         textSize: 12,
                                //         s: 'Select Date',
                                //         bgcolor: Colors.white,
                                //         textColor: appblueColor,
                                //         onPressed: () {
                                //           _selectDate(context).then((value) {
                                //             setState(() {
                                //               initialize();
                                //             });
                                //           });
                                //         },
                                //         borderRadius: 10,
                                //         borderColor: appblueColor,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: textColor.withOpacity(0.4),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  (date.day == DateTime.now().day &&
                                          date.month == DateTime.now().month &&
                                          date.year == DateTime.now().year)
                                      ? (DateTime.now().hour >= 12)
                                          ? SizedBox()
                                          : Slots(
                                              text: 'Morning',
                                              startTime: 0,
                                              endTime: 12,
                                              time: ' am')
                                      : Slots(
                                          text: 'Morning',
                                          startTime: 0,
                                          endTime: 12,
                                          time: ' am'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  (date.day == DateTime.now().day &&
                                          date.month == DateTime.now().month &&
                                          date.year == DateTime.now().year)
                                      ? (DateTime.now().hour >= 17)
                                          ? SizedBox()
                                          : Slots(
                                              text: 'Afternoon',
                                              startTime: 12,
                                              endTime: 17,
                                              time: ' pm')
                                      : Slots(
                                          text: 'Afternoon',
                                          startTime: 12,
                                          endTime: 17,
                                          time: ' pm'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  (date.day == DateTime.now().day &&
                                          date.month == DateTime.now().month &&
                                          date.year == DateTime.now().year)
                                      ? (DateTime.now().hour >=
                                              int.parse(slot_time
                                                  .data
                                                  .timeSlot[slot_time.data.timeSlot.length -
                                                      1]
                                                  .slotTime
                                                  .toString()
                                                  .substring(0, 2)))
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                ),
                                                Text(
                                                  'No Slots available for Today... You Can Book For Tomorrow',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: apptealColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )
                                          : Slots(
                                              text: 'Evening',
                                              startTime: 17,
                                              endTime: int.parse(slot_time.data.timeSlot[slot_time.data.timeSlot.length - 1].slotTime.toString().substring(0, 2)) +
                                                  1,
                                              time: ' pm')
                                      : Slots(
                                          text: 'Evening',
                                          startTime: 17,
                                          endTime: int.parse(slot_time
                                                  .data
                                                  .timeSlot[slot_time.data.timeSlot.length - 1]
                                                  .slotTime
                                                  .toString()
                                                  .substring(0, 2)) +
                                              1,
                                          time: ' pm'),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Text(
                              //   'Enter Comments',
                              //   style: GoogleFonts.montserrat(
                              //       fontSize: 14, fontWeight: FontWeight.bold),
                              // ),
                              // EnterField(
                              //   'Enter Comments',
                              //   'Enter Comments',
                              //   _controller,
                              // ),
                              // Text(
                              //   'Upload Report File',
                              //   style: GoogleFonts.montserrat(
                              //       fontSize: 14, fontWeight: FontWeight.bold),
                              // ),
                              // commonBtn(
                              //   s: 'Choose report',
                              //   height: 40,
                              //   textSize: 14,
                              //   bgcolor: Color(0xff161616).withOpacity(0.3),
                              //   textColor: Color(0xff161616),
                              //   onPressed: () {
                              //     pickFile();
                              //   },
                              //   borderRadius: 0,
                              // )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 150,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Booking For',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                color: textColor.withOpacity(0.4),
                                thickness: 1,
                              ),
                              Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButton(
                                      value: _con.bookingFor,
                                      underline: Container(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      isExpanded: true,
                                      hint: Text('Me'),
                                      items: relativeData.data.map((e) {
                                        return DropdownMenuItem(
                                            value: e.relative_id,
                                            child: Text(
                                                e.relativeName.toUpperCase()));
                                      }).toList(),
                                      onChanged: (dynamic v) {
                                        setState(() {
                                          print(v);
                                          _con.bookingFor = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: commonBtn(
                            s: 'Proceed',
                            bgcolor: appblueColor,
                            textColor: Colors.white,
                            borderRadius: 8,
                            onPressed: () {
                              _con.add_booking_request(
                                context,
                                fees: doctordetails
                                    .data.clinicDetails.oflineConsultancyFees,
                                date: '${date.year}-${date.month}-${date.day}',
                                doctor_id: widget.doc_id,
                                slot_time: selectedTime,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 30),
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

  Future pickFile() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    //
    // if (result != null) {
    //   _con.file = File(result.files.single.path!);
    // } else {
    //   // User canceled the picker
    // }
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      _con.file = result.files.first;
    }); // if user don't pick any thing then do nothing just return.
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
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 20,
            ),
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
                      ? (date.day == DateTime.now().day &&
                              date.month == DateTime.now().month &&
                              date.year == DateTime.now().year)
                          ? (DateTime.now().hour >
                                  int.parse(slot_time
                                      .data.timeSlot[index].slotTime
                                      .substring(0, 2)))
                              ? SizedBox()
                              : (DateTime.now().hour ==
                                      int.parse(slot_time
                                          .data.timeSlot[index].slotTime
                                          .substring(0, 2)))
                                  ? ((DateTime.now().minute <
                                          int.parse(slot_time
                                              .data.timeSlot[index].slotTime
                                              .substring(3, 5))))
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: commonBtn(
                                            s: slot_time.data.timeSlot[index]
                                                    .slotTime
                                                    .substring(0, 5)
                                                    .toString() +
                                                time,
                                            bgcolor: slot_time
                                                        .data
                                                        .timeSlot[index]
                                                        .status ==
                                                    'availiable'
                                                ? (_selectedindex == index)
                                                    ? apptealColor
                                                    : Colors.white
                                                : Colors.white,
                                            textColor: slot_time
                                                        .data
                                                        .timeSlot[index]
                                                        .status ==
                                                    'availiable'
                                                ? (_selectedindex == index)
                                                    ? Colors.white
                                                    : apptealColor
                                                : Colors.grey,
                                            onPressed: () {
                                              setState(() {
                                                _selectedindex = index;
                                                selectedTime = slot_time
                                                            .data
                                                            .timeSlot[index]
                                                            .status ==
                                                        'availiable'
                                                    ? slot_time
                                                        .data
                                                        .timeSlot[index]
                                                        .slotTime
                                                    : '';
                                                print(selectedTime +
                                                    '${_selectedindex}');
                                              });
                                            },
                                            textSize: 12,
                                            width: 90,
                                            borderRadius: 0,
                                            borderWidth: 1,
                                            borderColor: slot_time
                                                        .data
                                                        .timeSlot[index]
                                                        .status ==
                                                    'availiable'
                                                ? apptealColor
                                                : Colors.grey,
                                          ),
                                        )
                                      : SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: commonBtn(
                                        s: slot_time
                                                .data.timeSlot[index].slotTime
                                                .substring(0, 5)
                                                .toString() +
                                            time,
                                        bgcolor: slot_time.data.timeSlot[index]
                                                    .status ==
                                                'availiable'
                                            ? (_selectedindex == index)
                                                ? apptealColor
                                                : Colors.white
                                            : Colors.white,
                                        textColor: slot_time.data
                                                    .timeSlot[index].status ==
                                                'availiable'
                                            ? (_selectedindex == index)
                                                ? Colors.white
                                                : apptealColor
                                            : Colors.grey,
                                        onPressed: () {
                                          setState(() {
                                            _selectedindex = index;
                                            selectedTime = slot_time
                                                        .data
                                                        .timeSlot[index]
                                                        .status ==
                                                    'availiable'
                                                ? slot_time.data.timeSlot[index]
                                                    .slotTime
                                                : '';
                                            print(selectedTime +
                                                '${_selectedindex}');
                                          });
                                        },
                                        textSize: 12,
                                        width: 90,
                                        borderRadius: 0,
                                        borderWidth: 1,
                                        borderColor: slot_time.data
                                                    .timeSlot[index].status ==
                                                'availiable'
                                            ? apptealColor
                                            : Colors.grey,
                                      ),
                                    )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: commonBtn(
                                s: slot_time.data.timeSlot[index].slotTime
                                        .substring(0, 5)
                                        .toString() +
                                    time,
                                bgcolor:
                                    slot_time.data.timeSlot[index].status ==
                                            'availiable'
                                        ? (_selectedindex == index)
                                            ? apptealColor
                                            : Colors.white
                                        : Colors.white,
                                textColor:
                                    slot_time.data.timeSlot[index].status ==
                                            'availiable'
                                        ? (_selectedindex == index)
                                            ? Colors.white
                                            : apptealColor
                                        : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    _selectedindex = index;
                                    selectedTime =
                                        slot_time.data.timeSlot[index].status ==
                                                'availiable'
                                            ? slot_time
                                                .data.timeSlot[index].slotTime
                                            : '';
                                    print(selectedTime + '${_selectedindex}');
                                  });
                                },
                                textSize: 12,
                                width: 90,
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
