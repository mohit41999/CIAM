// To parse this JSON data, do
//
//     final myLabTestBooking = myLabTestBookingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyLabTestBooking myLabTestBookingFromJson(String str) =>
    MyLabTestBooking.fromJson(json.decode(str));

String myLabTestBookingToJson(MyLabTestBooking data) =>
    json.encode(data.toJson());

class MyLabTestBooking {
  MyLabTestBooking({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<MyLabTestBookingData> data;

  factory MyLabTestBooking.fromJson(Map<String, dynamic> json) =>
      MyLabTestBooking(
        status: json["status"],
        message: json["message"],
        data: List<MyLabTestBookingData>.from(json["data"].map((x) => MyLabTestBookingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyLabTestBookingData {
  MyLabTestBookingData({
    required this.booingId,
    required this.tests,
    required this.labId,
    required this.labName,
    required this.labImage,
    required this.ammountPaid,
    required this.location,
  });

  final String booingId;
  final List<String> tests;
  final String labId;
  final String labName;
  final String labImage;
  final String ammountPaid;
  final String location;

  factory MyLabTestBookingData.fromJson(Map<String, dynamic> json) => MyLabTestBookingData(
        booingId: json["booing_id"],
        tests: List<String>.from(json["tests"].map((x) => x)),
        labId: json["lab_id"],
        labName: json["lab_name"],
        labImage: json["lab_image"],
        ammountPaid: json["ammount_paid"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "booing_id": booingId,
        "tests": List<dynamic>.from(tests.map((x) => x)),
        "lab_id": labId,
        "lab_name": labName,
        "lab_image": labImage,
        "ammount_paid": ammountPaid,
        "location": location,
      };
}
