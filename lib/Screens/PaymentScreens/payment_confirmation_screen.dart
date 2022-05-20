import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/coupons_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/DoctorProfileController/confirm_booking_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/wallet_controller.dart';
import 'package:patient/helper/razorpay.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen(
      {Key? key,
      required this.amount,
      required this.booking_id,
      this.terms = false})
      : super(key: key);
  final String amount;
  final bool terms;
  final String booking_id;

  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  WalletController _controller = WalletController();
  String couponid = '';
  late CouponsModel coupons;
  Future<CouponsModel> getCoupons(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await PostData(PARAM_URL: 'get_coupon_list.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
    });
    return CouponsModel.fromJson(response);
  }

  Future getbillsummary(BuildContext context) async {
    var loader = ProgressView(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loader.show();
    var response = await PostData(PARAM_URL: 'bill_summary.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
      'booking_id': widget.booking_id,
      'coupen_id': couponid,
    });
    loader.dismiss();
    return response;
  }

  late Razorpay _razorpay;

  ConfirmBookingController _con = ConfirmBookingController();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // depositsuccess();
    print('order' + response.orderId.toString());
    print('paymentId' + response.paymentId.toString());
    print('signature' + response.signature.toString());

    _con.confirmBookingRequest(context, widget.booking_id).then((value) {
      _con
          .addPaymentTransaction(
              context, widget.booking_id, amount, widget.terms)
          .then((value) {});
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  late String amount;
  late String consultancy_fees;
  late String patientName;
  late String patientPhone;
  late String couponDiscount;
  bool loading = true;

  // Future getRazorpaycred() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var response = await PostData(
  //       PARAM_URL: 'get_razorpay_keys.php',
  //       params: {'token': Token, 'user_id': preferences.getString('user_id')});
  //   username = response['data']['razorpay_key_id'];
  //   password = response['data']['razorpay_key_secret'];
  //   return response;
  // }

  @override
  void initState() {
    getRazorpaycred();

    _controller.getwallet(context).then((value) {
      setState(() {});
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    amount = widget.amount;
    getbillsummary(context).then((value) {
      setState(() {
        amount = value['data']['to_be_paid'];
        patientName = value['data']['patient_name'];
        consultancy_fees = value['data']['consultancy_fees'];
        patientPhone = value['data']['patient_phone'];
        couponDiscount = value['data']['coupon_discount'];
        loading = false;
      });
    });
    getCoupons(context).then((value) {
      setState(() {
        coupons = value;
      });
    });
    super.initState();
  }

  int couponindex = -1;

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
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                                  fontSize: 15,
                                  color: Color(0xff252525).withOpacity(0.5)),
                            ),
                            Text(
                              patientName,
                              style: GoogleFonts.lato(
                                  fontSize: 22,
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
                                  fontSize: 15,
                                  color: Color(0xff252525).withOpacity(0.5)),
                            ),
                            Text(
                              patientPhone,
                              style: GoogleFonts.lato(
                                  fontSize: 22,
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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
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
                                                    onTap: () {
                                                      setState(() {
                                                        couponindex = index;
                                                        couponid = coupons
                                                            .data[index].id;
                                                        getbillsummary(context)
                                                            .then((value) {
                                                          setState(() {
                                                            amount = value[
                                                                        'data'][
                                                                    'to_be_paid']
                                                                .toString();
                                                            patientName = value[
                                                                    'data'][
                                                                'patient_name'];
                                                            consultancy_fees =
                                                                value['data'][
                                                                    'consultancy_fees'];
                                                            patientPhone = value[
                                                                    'data'][
                                                                'patient_phone'];
                                                            couponDiscount = value[
                                                                    'data'][
                                                                'coupon_discount'];
                                                            loading = false;
                                                          });
                                                        });
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      trailing: Text(
                                                          coupons.data[index]
                                                              .couponCode
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  color:
                                                                      apptealColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      leading: Text(
                                                        coupons
                                                            .data[index].title,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color:
                                                                    appblueColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ));
                              },
                              child: Text(
                                couponindex == -1
                                    ? 'Select Coupon'
                                    : coupons.data[couponindex].title,
                                style: GoogleFonts.montserrat(
                                    color: appblueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Text(couponindex == -1 ? '' : 'coupon applied'),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    couponindex = -1;
                                  });

                                  couponid = '';
                                  getbillsummary(context).then((value) {
                                    setState(() {
                                      amount = value['data']['to_be_paid']
                                          .toString();
                                      patientName =
                                          value['data']['patient_name'];
                                      consultancy_fees =
                                          value['data']['consultancy_fees'];
                                      patientPhone =
                                          value['data']['patient_phone'];
                                      couponDiscount =
                                          value['data']['coupon_discount'];
                                      loading = false;
                                    });
                                  });
                                },
                                child: (couponindex == -1)
                                    ? SizedBox()
                                    : Icon(Icons.cancel))
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Consultation Fee',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 15)),
                                  Text('₹ ' + consultancy_fees,
                                      style:
                                          GoogleFonts.montserrat(fontSize: 15))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Coupon Discount',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15, color: apptealColor)),
                                  Text('-₹ ' + couponDiscount,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15, color: apptealColor))
                                ],
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('To Be Paid',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text('₹ ' + amount,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 70,
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
                                Text('₹ ' + amount,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))
                              ],
                            )),
                            Expanded(
                                child: commonBtn(
                              s: 'Proceed to Pay  ',
                              bgcolor: appblueColor,
                              textColor: Colors.white,
                              onPressed: () {
                                payment(
                                    int.parse(
                                        amount.toString().replaceAll(".", "")),
                                    _razorpay);
                                // paymentdialog();
                              },
                              borderRadius: 10,
                            ))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future walletsuccess() async {
    _con.confirmBookingRequest(context, widget.booking_id).then((value) {
      _con
          .addPaymentTransaction(
              context, widget.booking_id, amount, widget.terms)
          .then((value) {});
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Payment Successfull'),
      backgroundColor: apptealColor,
    ));
  }

  Future showwalletConfirmation() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Wallet Balance : ${_controller.walletBalance}'),
              content: Container(
                height: MediaQuery.of(context).size.height / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonBtn(
                        width: 70,
                        borderRadius: 10,
                        s: 'No',
                        bgcolor: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          Pop(context);
                        }),
                    commonBtn(
                        width: 70,
                        borderRadius: 10,
                        s: 'Yes',
                        bgcolor: apptealColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Pop(context);
                          paywithWallet(amount).then((value) {
                            try {
                              (value['status'])
                                  ? walletsuccess()
                                  : ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content: Text(
                                          'Something went Wrong... try again or pay online'),
                                    ));
                            } catch (e) {
                              print(e.toString() + 'll');
                            }
                          });
                        }),
                  ],
                ),
              ),
            ));
  }

  Future paymentdialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Wallet Balance : ${_controller.walletBalance}'),
              content: Container(
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    commonBtn(
                        borderRadius: 10,
                        s: 'Pay With Wallet',
                        bgcolor: appblueColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Pop(context);
                          showwalletConfirmation();
                        }),
                    commonBtn(
                        borderRadius: 10,
                        s: 'Pay Online',
                        bgcolor: apptealColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Pop(context);
                          payment(
                              int.parse(amount.toString().replaceAll(".", "")),
                              _razorpay);
                        }),
                  ],
                ),
              ),
            ));
  }
}
