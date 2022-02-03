import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen({Key? key, required this.amount})
      : super(key: key);
  final String amount;

  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  late Razorpay _razorpay;
  String username = 'rzp_test_Wx4Pz8r5BYpqqQ';
  String password = '30RFYcp8Uty6yxx21eBLaX1W';

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // depositsuccess();
    print('order' + response.orderId.toString());
    print('paymentId' + response.paymentId.toString());
    print('signature' + response.signature.toString());
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

  void payment(String amount) async {
    final client = HttpClient();

    final request =
        await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('${username}:${password}'));
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    Object? orderOptions = {
      "amount": amount,
      "currency": "INR",
      "receipt": "Receipt no. 1",
      "payment_capture": 1,
      "notes": {
        "notes_key_1": "Tea, Earl Grey, Hot",
        "notes_key_2": "Tea, Earl Grey… decaf."
      }
    };
    request.add(utf8.encode(json.encode(orderOptions)));
    final response = await request.close();
    response.transform(utf8.decoder).listen((contents) {
      String orderId = contents.split(',')[0].split(":")[1];
      orderId = orderId.substring(1, orderId.length - 1);

      Map<String, dynamic> checkoutOptions = {
        'key': username,
        'amount': amount,
        "currency": "INR",
        'name': '',
        'description': '',
        'order_id': orderId, // Generate order_id using Orders API
        'timeout': 300,
      };
      try {
        _razorpay.open(checkoutOptions);
      } catch (e) {}
    });
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
                  onPressed: () {},
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
