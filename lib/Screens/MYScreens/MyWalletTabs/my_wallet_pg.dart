import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:patient/Screens/MYScreens/MyWalletTabs/request_for_redemption.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_enter_field.dart';

import 'wallet_transaction_history.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({Key? key}) : super(key: key);

  @override
  _MyWalletPageState createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'My Wallet'),
        backgroundColor: appAppBarColor,
        elevation: 0,
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
                      '\$499',
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
                      text: 'Wallet Transaction History',
                    ),
                    Tab(
                      text: 'Request for Redemption',
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
                  WalletTransactionHistory(),
                  RequestForRedemption(),
                  // second tab bar view widget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
