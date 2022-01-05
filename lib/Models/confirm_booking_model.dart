// To parse this JSON data, do
//
//     final confirmBooking = confirmBookingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConfirmBookingModel confirmBookingFromJson(String str) =>
    ConfirmBookingModel.fromJson(json.decode(str));

String confirmBookingToJson(ConfirmBookingModel data) =>
    json.encode(data.toJson());

class ConfirmBookingModel {
  ConfirmBookingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory ConfirmBookingModel.fromJson(Map<String, dynamic> json) =>
      ConfirmBookingModel(
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
    required this.bookedServiceTime,
    required this.clinicLocation,
    required this.totalAmount,
    required this.amountStatus,
    required this.bookingDate,
  });

  String bookingId;
  String specialty;
  String doctorName;
  String bookingStatus;
  String patientName;
  String patientLocation;
  String bookedServiceTime;
  String clinicLocation;
  String totalAmount;
  String amountStatus;
  String bookingDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingId: json["Booking Id"],
        specialty: json["Specialty"],
        doctorName: json["Doctor Name"],
        bookingStatus: json["Booking Status"],
        bookingDate: json["Booking Date"],
        patientName: json["Patient Name"],
        patientLocation: json["patient Location"],
        bookedServiceTime: json["Booked Service Time"],
        clinicLocation: json["Clinic Location"],
        totalAmount: json["Total Amount"],
        amountStatus: json["Amount Status"],
      );

  Map<String, dynamic> toJson() => {
        "Booking Id": bookingId,
        "Specialty": specialty,
        "Doctor Name": doctorName,
        "Booking Status": bookingStatus,
        "Booking Date": bookingDate,
        "Patient Name": patientName,
        "patient Location": patientLocation,
        "Booked Service Time": bookedServiceTime,
        "Clinic Location": clinicLocation,
        "Total Amount": totalAmount,
        "Amount Status": amountStatus,
      };
}
