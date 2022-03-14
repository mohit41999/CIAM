import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/coupons_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/DoctorProfileController/confirm_booking_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_column.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageCheckout extends StatefulWidget {
  @override
  _PackageCheckoutState createState() => _PackageCheckoutState();
}

class _PackageCheckoutState extends State<PackageCheckout> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'Payment Confirmation'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Patient Name',
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            color: Color(0xff252525).withOpacity(0.5)),
                      ),
                      Text(
                        'patientName',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Color(0xff252525),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Patient Phone Number',
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            color: Color(0xff252525).withOpacity(0.5)),
                      ),
                      Text(
                        'patientPhone',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Color(0xff252525),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xffEFEFEF),
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lab Details'),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Text(
                          'Lab Name',
                          style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Color(0xff252525).withOpacity(0.5)),
                        ),
                        Text(
                          'Lab Name',
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Color(0xff252525),
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: apptealColor,
                            ),
                            Text(' Location')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xffEFEFEF),
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Test Details'),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Test Name',
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Color(0xff252525).withOpacity(0.5)),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '\$100',
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Color(0xff252525).withOpacity(0.5)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Test Name',
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Color(0xff252525).withOpacity(0.5)),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '\$100',
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Color(0xff252525).withOpacity(0.5)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Test Name',
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Color(0xff252525).withOpacity(0.5)),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '\$100',
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Color(0xff252525).withOpacity(0.5)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xffEFEFEF),
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 50,
                        child: Center(
                          child: Text(
                            '%',
                            style: GoogleFonts.montserrat(
                                color: appblueColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: apptealColor),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Container(
                                      height: 250,
                                      width: 300,
                                      child: ListView.builder(
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {},
                                              child: ListTile(
                                                trailing: Text('Coupon $index',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: apptealColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                leading: Text(
                                                  'Coupon $index',
                                                  style: GoogleFonts.montserrat(
                                                      color: appblueColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ));
                        },
                        child: Text(
                          'Select Coupon',
                          style: GoogleFonts.montserrat(
                              color: appblueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Text('Coupon'),
                      GestureDetector(onTap: () {}, child: SizedBox())
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xffEFEFEF),
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bill Summary',
                          style: GoogleFonts.montserrat(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Consultation Fee',
                                style: GoogleFonts.montserrat(fontSize: 15)),
                            Text('₹ ' + 'consultancy_fees',
                                style: GoogleFonts.montserrat(fontSize: 15))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Coupon Discount',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, color: apptealColor)),
                            Text('-₹ ' + 'couponDiscount',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, color: apptealColor))
                          ],
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.7),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('To Be Paid',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('₹ ' + 'amount',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xffEFEFEF),
                  height: 20,
                ),
                SizedBox(
                  height: navbarht + 20,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.zero,
                child: Container(
                  height: 70,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Amount\n',
                              style: GoogleFonts.montserrat(fontSize: 15),
                            ),
                            Text('₹ ' + 'amount',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        )),
                        Expanded(
                            child: commonBtn(
                          s: 'Proceed to Pay  ',
                          bgcolor: appblueColor,
                          textColor: Colors.white,
                          onPressed: () {},
                          borderRadius: 10,
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
