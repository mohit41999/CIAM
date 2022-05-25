// To parse this JSON data, do
//
//     final myLabPackageBooking = myLabPackageBookingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyLabPackageBooking myLabPackageBookingFromJson(String str) =>
    MyLabPackageBooking.fromJson(json.decode(str));

String myLabPackageBookingToJson(MyLabPackageBooking data) =>
    json.encode(data.toJson());

class MyLabPackageBooking {
  MyLabPackageBooking({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<MyLabPackageBookingDatum> data;

  factory MyLabPackageBooking.fromJson(Map<String, dynamic> json) =>
      MyLabPackageBooking(
        status: json["status"],
        message: json["message"],
        data: List<MyLabPackageBookingDatum>.from(json["data"].map((x) => MyLabPackageBookingDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyLabPackageBookingDatum {
  MyLabPackageBookingDatum({
    required this.booingId,
    required this.packageId,
    required this.packageName,
    required this.labId,
    required this.labName,
    required this.labImage,
    required this.ammountPaid,
    required this.location,
  });

  final String booingId;
  final String packageId;
  final String packageName;
  final String labId;
  final String labName;
  final String labImage;
  final String ammountPaid;
  final String location;

  factory MyLabPackageBookingDatum.fromJson(Map<String, dynamic> json) => MyLabPackageBookingDatum(
        booingId: json["booing_id"],
        packageId: json["package_id"],
        packageName: json["package_name"],
        labId: json["lab_id"],
        labName: json["lab_name"],
        labImage: json["lab_image"],
        ammountPaid: json["ammount_paid"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "booing_id": booingId,
        "package_id": packageId,
        "package_name": packageName,
        "lab_id": labId,
        "lab_name": labName,
        "lab_image": labImage,
        "ammount_paid": ammountPaid,
        "location": location,
      };
}
