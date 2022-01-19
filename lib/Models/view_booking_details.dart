// To parse this JSON data, do
//
//     final viewBookingDetails = viewBookingDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ViewBookingDetailsModel viewBookingDetailsFromJson(String str) =>
    ViewBookingDetailsModel.fromJson(json.decode(str));

String viewBookingDetailsToJson(ViewBookingDetailsModel data) =>
    json.encode(data.toJson());

class ViewBookingDetailsModel {
  ViewBookingDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory ViewBookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      ViewBookingDetailsModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.bookingId,
    required this.specialty,
    required this.doctorName,
    required this.bookingStatus,
    required this.patientName,
    required this.patientLocation,
    required this.bookedDate,
    required this.bookedServiceTime,
    required this.clinicLocation,
    required this.totalAmount,
    required this.Doctor_Id,
    required this.amountStatus,
  });

  String bookingId;
  String specialty;
  String doctorName;
  String bookingStatus;
  String Doctor_Id;
  String patientName;
  String patientLocation;
  String bookedDate;
  String bookedServiceTime;
  String clinicLocation;
  String totalAmount;
  String amountStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingId: json["Booking Id"],
        specialty: json["Specialty"],
        Doctor_Id: json["Doctor Id"],
        doctorName: json["Doctor Name"],
        bookingStatus: json["Booking Status"],
        patientName: json["Patient Name"],
        patientLocation: json["patient Location"],
        bookedDate: json["Booked Date"],
        bookedServiceTime: json["Booked Service Time"],
        clinicLocation: json["Clinic Location"],
        totalAmount: json["Total Amount"],
        amountStatus: json["Amount Status"],
      );

  Map<String, dynamic> toJson() => {
        "Booking Id": bookingId,
        "Specialty": specialty,
        "Doctor Name": doctorName,
        "Doctor Id": Doctor_Id,
        "Booking Status": bookingStatus,
        "Patient Name": patientName,
        "patient Location": patientLocation,
        "Booked Date": bookedDate,
        "Booked Service Time": bookedServiceTime,
        "Clinic Location": clinicLocation,
        "Total Amount": totalAmount,
        "Amount Status": amountStatus,
      };
}
