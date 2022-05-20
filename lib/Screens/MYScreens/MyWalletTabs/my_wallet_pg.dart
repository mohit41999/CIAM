import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:patient/Models/wallet_history.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/wallet_controller.dart';
import 'package:patient/helper/razorpay.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_column.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({Key? key}) : super(key: key);

  @override
  _MyWalletPageState createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage>
    with SingleTickerProviderStateMixin {
  WalletController _controller = WalletController();

  late Razorpay _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // depositsuccess();
    _controller.depositWallet(context, depositamount.text).then((value) {
      setState(() {
        depositamount.clear();
      });
    });

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
  TextEditingController depositamount = TextEditingController();
  TextEditingController withdrawamount = TextEditingController();

  late TabController _tabController;
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();

  @override
  void initState() {
    _razorpay = Razorpay();
    getRazorpaycred();
    print(username + 'ussss');
    print(password + 'ussss');
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _tabController = TabController(length: 3, vsync: this);

    _controller.getwallet(context).then((value) {
      setState(() {
        _controller.getwalletTransaction(context).then((value) {
          setState(() {
            print(value.toString() + 'lllllllll');
            _controller.walletTransaction = value;
            _controller.historyloading = false;
          });
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: commonAppBarTitleText(appbarText: 'My Wallet'),
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Wallet Balance:',
                      style: GoogleFonts.montserrat(fontSize: 20),
                    ),
                    Text(
                      _controller.walletBalance,
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: appblueColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                  labelPadding: EdgeInsets.only(right: 4, left: 0),
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: appblueColor),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  labelColor: appblueColor,
                  indicatorColor: appblueColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: 'Wallet Transaction \nHistory',
                    ),
                    Tab(
                      text: 'Deposit',
                    ),
                    Tab(
                      text: 'Withdraw',
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 0,
              color: Colors.grey.withOpacity(0.5),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  wallettransaction(),
                  Deposit(),
                  WithDraw()

                  // second tab bar view widget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget wallettransaction() {
    return (_controller.historyloading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : (_controller.walletTransaction.toString() == 'null')
            ? Center(child: Text('Error.. please try later'))
            : ListView.builder(
                itemCount: _controller.walletTransaction!.data.length,
                itemBuilder: (context, index) {
                  WalletTransactionData transactionHistory =
                      _controller.walletTransaction!.data[index];

                  return Padding(
                    padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 8.0,
                        bottom: (index + 1 ==
                                _controller.walletTransaction!.data.length)
                            ? navbarht + 20
                            : 8.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8),
                        child: Container(
                          height: 86,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    titleColumn(
                                        title: 'Transaction Id',
                                        value: transactionHistory.txnId),
                                    titleColumn(
                                        title: 'Order Id / Service Id',
                                        value: transactionHistory.id),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    titleColumn(
                                        title: 'Transaction Date',
                                        value: transactionHistory.txnDate),
                                    titleColumn(
                                        title: 'Transaction Amount',
                                        value: transactionHistory.amount),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
  }

  Widget Deposit() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleEnterField(
              'Enter Amount',
              'Amount',
              depositamount,
              textInputType: TextInputType.number,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                left: 8.0, right: 8.0, top: 8.0, bottom: navbarht + 20),
            child: commonBtn(
              s: 'Submit  ',
              bgcolor: appblueColor,
              textColor: Colors.white,
              onPressed: () {
                if (depositamount.text.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Enter Amount')));
                } else if (depositamount.text.contains('.')) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Enter Amount Without decimal')));
                } else {
                  payment(int.parse(depositamount.text + '00'), _razorpay);
                }
              },
              borderRadius: 8,
            ),
          ),
        )
      ],
    );
  }

  Widget WithDraw() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleEnterField(
              'Enter Amount',
              'Amount',
              withdrawamount,
              textInputType: TextInputType.number,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                left: 8.0, right: 8.0, top: 8.0, bottom: navbarht + 20),
            child: commonBtn(
              s: 'Submit  ',
              bgcolor: appblueColor,
              textColor: Colors.white,
              onPressed: () {
                if (withdrawamount.text.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Enter Amount')));
                } else {
                  _controller
                      .withDrawWallet(context, withdrawamount.text)
                      .then((value) {
                    setState(() {
                      withdrawamount.clear();
                    });
                  });
                }
              },
              borderRadius: 8,
            ),
          ),
        )
      ],
    );
  }
}
