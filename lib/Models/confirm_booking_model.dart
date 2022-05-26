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
    required this.doctorId,
    required this.specialty,
    required this.doctorName,
    required this.doctorProfile,
    required this.bookingStatus,
    required this.patientDetails,
    required this.bookedServiceTime,
    required this.bookingDate,
    required this.clinicLocation,
    required this.fees,
    required this.couponDiscount,
    required this.toBePaid,
    required this.amountStatus,
    required this.date,
    required this.doctorReports,
    required this.videoConsultancyComplete,
  });

  String bookingId;
  String doctorId;
  String specialty;
  String doctorName;
  String doctorProfile;
  String bookingStatus;
  PatientDetails patientDetails;
  String bookedServiceTime;
  String bookingDate;
  String clinicLocation;
  String fees;
  String couponDiscount;
  String toBePaid;
  String amountStatus;
  String date;
  List<dynamic> doctorReports;
  String videoConsultancyComplete;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingId: json["Booking Id"],
        doctorId: json["doctor id"],
        specialty: json["Specialty"] ?? '',
        doctorName: json["Doctor Name"],
        doctorProfile: json["Doctor Profile"],
        bookingStatus: json["Booking Status"],
        patientDetails: PatientDetails.fromJson(json["Patient Details"]),
        bookedServiceTime: json["Booked Service Time"],
        bookingDate: json["Booking Date"],
        clinicLocation: json["Clinic Location"],
        fees: json["Fees"],
        couponDiscount: json["coupon_discount"],
        toBePaid: json["to_be_paid"],
        amountStatus: json["Amount Status"],
        date: json["Date"],
        doctorReports: List<dynamic>.from(json["doctor_reports"].map((x) => x)),
        videoConsultancyComplete: json["video_consultancy_complete"],
      );

  Map<String, dynamic> toJson() => {
        "Booking Id": bookingId,
        "doctor id": doctorId,
        "Specialty": specialty,
        "Doctor Name": doctorName,
        "Doctor Profile": doctorProfile,
        "Booking Status": bookingStatus,
        "Patient Details": patientDetails.toJson(),
        "Booked Service Time": bookedServiceTime,
        "Booking Date": bookingDate,
        "Clinic Location": clinicLocation,
        "Fees": fees,
        "coupon_discount": couponDiscount,
        "to_be_paid": toBePaid,
        "Amount Status": amountStatus,
        "Date": date,
        "doctor_reports": List<dynamic>.from(doctorReports.map((x) => x)),
        "video_consultancy_complete": videoConsultancyComplete,
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
