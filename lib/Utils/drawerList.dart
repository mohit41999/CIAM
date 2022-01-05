import 'package:flutter/material.dart';
import 'package:patient/Screens/MYScreens/MyAppointments.dart';
import 'package:patient/Screens/MYScreens/MyLabTest.dart';
import 'package:patient/Screens/MYScreens/MyMedicineOrders.dart';
import 'package:patient/Screens/MYScreens/MyOrderPage.dart';
import 'package:patient/Screens/MYScreens/MyPrescriprions.dart';
import 'package:patient/Screens/MYScreens/MyQuestionsScreen.dart';
import 'package:patient/Screens/MYScreens/MyReviewRating.dart';
import 'package:patient/Screens/MYScreens/MyWalletTabs/my_wallet_pg.dart';
import 'package:patient/Screens/ProfileSettings/profile_setting.dart';
import 'package:patient/Screens/account_settings.dart';
import 'package:patient/Screens/chats_screen.dart';

List<Map<dynamic, dynamic>> drawerList = [
  {
    'label': 'Profile',
    'Screen': ProfileSetting(),
  },
  {
    'label': 'My Appointment',
    'Screen': MyAppointments(),
  },
  {
    'label': 'My Chats',
    'Screen': ChatsScrren(),
  },
  {
    'label': 'My Lab Test',
    'Screen': MyLabTest(),
  },
  {
    'label': 'My Medicine Orders',
    'Screen': MyMedicineOrders(),
  },
  {
    'label': 'My Order',
    'Screen': MyOrderPg(),
  },
  {
    'label': 'My Reviews and Rating',
    'Screen': MyReviewRatingsScreen(),
  },
  {
    'label': 'My Questions',
    'Screen': MyQuestionsScreen(),
  },
  {
    'label': 'My Wallets',
    'Screen': MyWalletPage(),
  },
  {
    'label': 'My Prescriptions',
    'Screen': MyPrescriptionsScreen(),
  },
  {
    'label': 'Account Setting',
    'Screen': AccountSetting(),
  },
  {
    'label': 'Logout',
    'Screen': 'null',
  },
];
