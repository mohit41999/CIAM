// To parse this JSON data, do
//
//     final myLabTestModel = myLabTestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyLabTestModel myLabTestModelFromJson(String str) =>
    MyLabTestModel.fromJson(json.decode(str));

String myLabTestModelToJson(MyLabTestModel data) => json.encode(data.toJson());

class MyLabTestModel {
  MyLabTestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory MyLabTestModel.fromJson(Map<String, dynamic> json) => MyLabTestModel(
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
    required this.testName,
    required this.price,
    required this.ammountPaid,
    required this.bookingDate,
  });

  final String testName;
  final String price;
  final String ammountPaid;
  final String bookingDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        testName: json["test_name"],
        price: json["price"],
        ammountPaid: json["ammount_paid"],
        bookingDate: json["booking_date"],
      );

  Map<String, dynamic> toJson() => {
        "test_name": testName,
        "price": price,
        "ammount_paid": ammountPaid,
        "booking_date": bookingDate,
      };
}
