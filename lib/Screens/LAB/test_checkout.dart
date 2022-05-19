import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:patient/Models/LAB/test_checkout_model.dart';
import 'package:patient/Models/coupons_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/LabController/test_controller.dart';
import 'package:patient/controller/wallet_controller.dart';
import 'package:patient/helper/constants.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../helper/constants.dart';

class TestCheckout extends StatefulWidget {
  final String labid;
  final List<String> testids;

  const TestCheckout({Key? key, required this.labid, required this.testids})
      : super(key: key);

  @override
  _TestCheckoutState createState() => _TestCheckoutState();
}

class _TestCheckoutState extends State<TestCheckout> {
  WalletController walletController = WalletController();
  String couponid = '';
  int couponindex = -1;
  late CouponsModel coupons;
  late Razorpay _razorpay;

  TestController controller = TestController();
  late TestCheckoutModel checkoutsummary;
  Future initialize() async {
    await getRazorpaycred();
    walletController.getwallet(context);
    print(password + 'usssss');
    print(username + 'paasss');
    checkoutsummary =
        await controller.getTestCheckout(widget.labid, widget.testids, '');
    setState(() {});
    coupons = await controller.getCoupons(context);
    setState(() {});
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // depositsuccess();
    print('order' + response.orderId.toString());
    print('paymentId' + response.paymentId.toString());
    print('signature' + response.signature.toString());
    controller.addTestOrder(widget.labid, widget.testids, couponid,
        checkoutsummary.data.billSummary.totalFees);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initialize();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: commonAppBarTitleText(appbarText: 'Payment Confirmation'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        titleSpacing: 0,
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
                        checkoutsummary.data.patientDetails.patientName,
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
                        checkoutsummary.data.patientDetails.patientNo,
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
                          checkoutsummary.data.labDetails.labName,
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
                            Text(' ' + checkoutsummary.data.labDetails.location)
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Test Details'),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: checkoutsummary.data.testDtails.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        checkoutsummary
                                            .data.testDtails[index].testName,
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: Color(0xff252525)
                                                .withOpacity(0.5)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '₹ ' +
                                            checkoutsummary
                                                .data.testDtails[index].price,
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: Color(0xff252525)
                                                .withOpacity(0.5)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
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
                                          itemCount: coupons.data.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                couponindex = index;
                                                couponid =
                                                    coupons.data[index].id;
                                                checkoutsummary =
                                                    await controller
                                                        .getTestCheckout(
                                                            widget.labid,
                                                            widget.testids,
                                                            couponid);
                                                setState(() {});

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                trailing: Text(
                                                    coupons
                                                        .data[index].couponCode
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: apptealColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                leading: Text(
                                                  coupons.data[index].title,
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
                            Text(
                                '₹ ' +
                                    checkoutsummary.data.billSummary.totalFees,
                                style: GoogleFonts.montserrat(fontSize: 15))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Coupon Discount',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, color: apptealColor)),
                            Text(
                                '-₹ ' +
                                    checkoutsummary
                                        .data.billSummary.couponDiscount,
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
                            Text(
                                '₹ ' +
                                    checkoutsummary.data.billSummary.amountPaid,
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
                            Text(
                                '₹ ' +
                                    checkoutsummary.data.billSummary.amountPaid,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        )),
                        Expanded(
                            child: commonBtn(
                          s: 'Proceed to Pay ',
                          bgcolor: appblueColor,
                          textColor: Colors.white,
                          onPressed: () {
                            payment(
                                int.parse(checkoutsummary
                                    .data.billSummary.amountPaid
                                    .replaceAll('.', '')),
                                _razorpay);
                          },
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
