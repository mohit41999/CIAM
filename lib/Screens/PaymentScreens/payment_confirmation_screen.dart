import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/DoctorProdileController/confirm_booking_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen(
      {Key? key, required this.amount, required this.booking_id})
      : super(key: key);
  final String amount;
  final String booking_id;

  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  late Razorpay _razorpay;
  String username = 'rzp_test_Wx4Pz8r5BYpqqQ';
  String password = '30RFYcp8Uty6yxx21eBLaX1W';
  ConfirmBookingController _con = ConfirmBookingController();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // depositsuccess();
    print('order' + response.orderId.toString());
    print('paymentId' + response.paymentId.toString());
    print('signature' + response.signature.toString());

    _con.confirmBookingRequest(context, widget.booking_id).then((value) {
      _con
          .addPaymentTransaction(context, widget.booking_id, widget.amount)
          .then((value) {});
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }

  void payment(int amount) async {
    var authn = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Object? orderOptions = {
      "amount": amount,
      "currency": "INR",
      "receipt": "Receipt no. 1",
      "payment_capture": 1,
    };
    var headers = {
      'content-type': 'application/json',
      'Authorization': authn,
    };
    // final client = HttpClient();
    var res = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: headers, body: json.encode(orderOptions));

    print(jsonDecode(res.body).toString() +
        '======================================');

    String order_id = jsonDecode(res.body)['id'].toString();
    // final request =
    //     await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    // request.headers
    //     .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    // String basicAuth =
    //     'Basic ' + base64Encode(utf8.encode('${username}:${password}'));
    // request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    //
    // request.add(utf8.encode(json.encode(orderOptions)));
    // final response = await request.close();
    // response.transform(utf8.decoder).listen((contents) {
    //   String orderId = contents;
    //
    //
    // });
    Map<String, dynamic> checkoutOptions = {
      'key': username,
      'amount': amount,
      "currency": "INR",
      'name': '',
      'description': '',
      'order_id': order_id, // Generate order_id using Orders API
      'timeout': 3000,
    };
    try {
      _razorpay.open(checkoutOptions);
    } catch (e) {}
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Terms and Conditions'),
              Text('Amount: ' + widget.amount),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: commonBtn(
                  s: 'Pay Now',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {
                    payment(int.parse(
                        widget.amount.toString().replaceAll(".", "")));
                  },
                  borderRadius: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
