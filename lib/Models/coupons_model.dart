// To parse this JSON data, do
//
//     final couponsModel = couponsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CouponsModel couponsModelFromJson(String str) =>
    CouponsModel.fromJson(json.decode(str));

String couponsModelToJson(CouponsModel data) => json.encode(data.toJson());

class CouponsModel {
  CouponsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory CouponsModel.fromJson(Map<String, dynamic> json) => CouponsModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.couponCode,
    required this.discountType,
    required this.discount,
    required this.fromDate,
    required this.toDate,
    required this.usageLimit,
  });

  String id;
  String title;
  String couponCode;
  String discountType;
  String discount;
  DateTime fromDate;
  DateTime toDate;
  String usageLimit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        couponCode: json["coupon_code"],
        discountType: json["discount_type"],
        discount: json["discount"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        usageLimit: json["usage_limit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "coupon_code": couponCode,
        "discount_type": discountType,
        "discount": discount,
        "from_date":
            "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "usage_limit": usageLimit,
      };
}
