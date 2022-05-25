// To parse this JSON data, do
//
//     final myAppointmentsModel = myAppointmentsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyAppointmentsModel myAppointmentsModelFromJson(String str) =>
    MyAppointmentsModel.fromJson(json.decode(str));

String myAppointmentsModelToJson(MyAppointmentsModel data) =>
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
    required this.bookingId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.doctorId,
    required this.doctorName,
    required this.profileImage,
    required this.consultancyFees,
    required this.couponDiscount,
    required this.ammountPaid,
    required this.location,
    required this.status,
  });

  String bookingId;
  String appointmentDate;
  String appointmentTime;
  String doctorId;
  String doctorName;
  String profileImage;
  String consultancyFees;
  String couponDiscount;
  String ammountPaid;
  String location;
  String status;

  factory MyAppointmentsModelData.fromJson(Map<String, dynamic> json) =>
      MyAppointmentsModelData(
        bookingId: json["booking_id"],
        appointmentDate: json["appointment_date"],
        appointmentTime: json["appointment_time"],
        doctorId: json["doctor_id"],
        doctorName: json["doctor_name"],
        profileImage: json["profile_image"],
        consultancyFees: json["consultancy_fees"],
        couponDiscount: json["coupon_discount"],
        ammountPaid: json["ammount_paid"],
        location: json["location"]??'',
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "appointment_date": appointmentDate,
        "appointment_time": appointmentTime,
        "doctor_id": doctorId,
        "doctor_name": doctorName,
        "profile_image": profileImage,
        "consultancy_fees": consultancyFees,
        "coupon_discount": couponDiscount,
        "ammount_paid": ammountPaid,
        "location": location,
        "Status": status,
      };
}
