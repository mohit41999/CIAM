import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/API%20repo/api_end_points.dart';
import 'package:patient/Models/wallet_history.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletController {
  String walletBalance = '';
  late WalletTransactionModel? walletTransaction;
  bool historyloading = true;

  Future getwallet(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.my_wallet,
        params: {'token': Token, 'user_id': preferences.getString('user_id')});
    if (response['status']) {
      walletBalance = response['data']['wallet_balance'];
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
    }
  }

  Future depositWallet(BuildContext context, String amount) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response =
        await PostData(PARAM_URL: AppEndPoints.deposit_wallet, params: {
      'token': Token,
      'user_id': preferences.getString('user_id'),
      'amount': amount,
      'payment_status': 'success'
    });
    if (response['status']) {
      await getwallet(context);
      walletTransaction = (await getwalletTransaction(context))!;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
    }
  }

  Future withDrawWallet(BuildContext context, String amount) async {
    var loader = ProgressView(context);
    loader.show();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.withdrawal_request,
        params: {
          'token': Token,
          'user_id': preferences.getString('user_id'),
          'amount': amount
        });
    loader.dismiss();
    if (response['status']) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
      await getwallet(context);
      walletTransaction = (await getwalletTransaction(context))!;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
    }
  }

  Future<WalletTransactionModel?> getwalletTransaction(
      BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: AppEndPoints.wallet_transaction_history,
        params: {
          'token': Token,
          'user_id': preferences.getString('user_id'),
        });

    if (response['status']) {
      return WalletTransactionModel.fromJson(response);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['message'])));
      return null;
    }
  }
}
