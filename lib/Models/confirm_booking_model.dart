// To parse this JSON data, do
//
//     final confirmBookingModel = confirmBookingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConfirmBookingModel confirmBookingModelFromJson(String str) =>
    ConfirmBookingModel.fromJson(json.decode(str));

String confirmBookingModelToJson(ConfirmBookingModel data) =>
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
    required this.doctorProfile,
    required this.bookingStatus,
    required this.patientDetails,
    required this.bookedServiceTime,
    required this.bookingDate,
    required this.clinicLocation,
    required this.totalAmount,
    required this.amountStatus,
    required this.patient_document,
  });

  String bookingId;
  String specialty;
  String doctorName;
  String doctorProfile;
  String bookingStatus;
  PatientDetails patientDetails;
  String bookedServiceTime;
  String bookingDate;
  String patient_document;
  String clinicLocation;
  String totalAmount;
  String amountStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingId: json["Booking Id"],
        specialty: json["Specialty"],
        doctorName: json["Doctor Name"],
        doctorProfile: json["Doctor Profile"],
        patient_document: json["patient_document"],
        bookingStatus: json["Booking Status"],
        patientDetails: PatientDetails.fromJson(json["Patient Details"]),
        bookedServiceTime: json["Booked Service Time"],
        bookingDate: json["Booking Date"],
        clinicLocation: json["Clinic Location"],
        totalAmount: json["Total Amount"],
        amountStatus: json["Amount Status"],
      );

  Map<String, dynamic> toJson() => {
        "Booking Id": bookingId,
        "Specialty": specialty,
        "Doctor Name": doctorName,
        "Doctor Profile": doctorProfile,
        "patient_document": patient_document,
        "Booking Status": bookingStatus,
        "Patient Details": patientDetails.toJson(),
        "Booked Service Time": bookedServiceTime,
        "Booking Date": bookingDate,
        "Clinic Location": clinicLocation,
        "Total Amount": totalAmount,
        "Amount Status": amountStatus,
      };
}

class PatientDetails {
  PatientDetails({
    required this.patientName,
    required this.patientAge,
  });

  String patientName;
  String patientAge;

  factory PatientDetails.fromJson(Map<String, dynamic> json) => PatientDetails(
        patientName: json["Patient Name"],
        patientAge: json["Patient Age"],
      );

  Map<String, dynamic> toJson() => {
        "Patient Name": patientName,
        "Patient Age": patientAge,
      };
}
