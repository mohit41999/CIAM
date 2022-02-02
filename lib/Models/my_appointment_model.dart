// To parse this JSON data, do
//
//     final myAppointment = myAppointmentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyAppointmentsModel myAppointmentFromJson(String str) =>
    MyAppointmentsModel.fromJson(json.decode(str));

String myAppointmentToJson(MyAppointmentsModel data) =>
    json.encode(data.toJson());

class MyAppointmentsModel {
  MyAppointmentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<MyAppointmentsModelData> data;

  factory MyAppointmentsModel.fromJson(Map<String, dynamic> json) =>
      MyAppointmentsModel(
        status: json["status"],
        message: json["message"],
        data: List<MyAppointmentsModelData>.from(
            json["data"].map((x) => MyAppointmentsModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyAppointmentsModelData {
  MyAppointmentsModelData({
    required this.booingId,
    required this.doctorName,
    required this.doctorId,
    required this.location,
    required this.status,
    required this.profile,
    required this.bookingDate,
    required this.fees,
  });

  String booingId;
  String doctorName;
  String doctorId;
  dynamic location;
  String status;
  String profile;
  String bookingDate;
  String fees;

  factory MyAppointmentsModelData.fromJson(Map<String, dynamic> json) =>
      MyAppointmentsModelData(
        booingId: json["booing id"],
        doctorId: json["Doctor id"],
        doctorName: json["Doctor Name"],
        location: json["Location"],
        status: json["Status"],
        profile: json["Profile"],
        bookingDate: json["Booking Date"],
        fees: json["Fees"],
      );

  Map<String, dynamic> toJson() => {
        "booing id": booingId,
        "Doctor Name": doctorName,
        "Doctor id": doctorId,
        "Location": location,
        "Status": status,
        "Profile": profile,
        "Booking Date": bookingDate,
        "Fees": fees,
      };
}
