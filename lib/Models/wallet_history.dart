// To parse this JSON data, do
//
//     final walletTransactionModel = walletTransactionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WalletTransactionModel walletTransactionModelFromJson(String str) =>
    WalletTransactionModel.fromJson(json.decode(str));

String walletTransactionModelToJson(WalletTransactionModel data) =>
    json.encode(data.toJson());

class WalletTransactionModel {
  WalletTransactionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<WalletTransactionData> data;

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) =>
      WalletTransactionModel(
        status: json["status"],
        message: json["message"],
        data: List<WalletTransactionData>.from(
            json["data"].map((x) => WalletTransactionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WalletTransactionData {
  WalletTransactionData({
    required this.id,
    required this.txnId,
    required this.amount,
    required this.paymentStatus,
    required this.remarks,
    required this.txnDate,
  });

  String id;
  String txnId;
  String amount;
  String paymentStatus;
  String remarks;
  String txnDate;

  factory WalletTransactionData.fromJson(Map<String, dynamic> json) =>
      WalletTransactionData(
        id: json["id"],
        txnId: json["txn_id"],
        amount: json["amount"],
        paymentStatus: json["payment_status"],
        remarks: json["remarks"],
        txnDate: json["txn_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "txn_id": txnId,
        "amount": amount,
        "payment_status": paymentStatus,
        "remarks": remarks,
        "txn_date": txnDate,
      };
}
