// To parse this JSON data, do
//
//     final packageCheckoutModel = packageCheckoutModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PackageCheckoutModel packageCheckoutModelFromJson(String str) =>
    PackageCheckoutModel.fromJson(json.decode(str));

String packageCheckoutModelToJson(PackageCheckoutModel data) =>
    json.encode(data.toJson());

class PackageCheckoutModel {
  PackageCheckoutModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<PackageCheckoutModelData> data;

  factory PackageCheckoutModel.fromJson(Map<String, dynamic> json) =>
      PackageCheckoutModel(
        status: json["status"],
        message: json["message"],
        data: List<PackageCheckoutModelData>.from(
            json["data"].map((x) => PackageCheckoutModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PackageCheckoutModelData {
  PackageCheckoutModelData({
    required this.patientDetails,
    required this.labDetails,
    required this.packageDetails,
    required this.billSummary,
  });

  final PatientDetails patientDetails;
  final LabDetails labDetails;
  final PackageDetails packageDetails;
  final BillSummary billSummary;

  factory PackageCheckoutModelData.fromJson(Map<String, dynamic> json) =>
      PackageCheckoutModelData(
        patientDetails: PatientDetails.fromJson(json["patient_details"]),
        labDetails: LabDetails.fromJson(json["lab_details"]),
        packageDetails: PackageDetails.fromJson(json["package_details"]),
        billSummary: BillSummary.fromJson(json["bill_summary"]),
      );

  Map<String, dynamic> toJson() => {
        "patient_details": patientDetails.toJson(),
        "lab_details": labDetails.toJson(),
        "package_details": packageDetails.toJson(),
        "bill_summary": billSummary.toJson(),
      };
}

class BillSummary {
  BillSummary({
    required this.totalFees,
    required this.couponDiscount,
    required this.amountPaid,
  });

  final String totalFees;
  final String couponDiscount;
  final String amountPaid;

  factory BillSummary.fromJson(Map<String, dynamic> json) => BillSummary(
        totalFees: json["total_fees"],
        couponDiscount: json["coupon_discount"],
        amountPaid: json["amount_paid"],
      );

  Map<String, dynamic> toJson() => {
        "total_fees": totalFees,
        "coupon_discount": couponDiscount,
        "amount_paid": amountPaid,
      };
}

class LabDetails {
  LabDetails({
    required this.labId,
    required this.labName,
    required this.location,
  });

  final String labId;
  final String labName;
  final String location;

  factory LabDetails.fromJson(Map<String, dynamic> json) => LabDetails(
        labId: json["lab_id"],
        labName: json["lab_name"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "lab_id": labId,
        "lab_name": labName,
        "location": location,
      };
}

class PackageDetails {
  PackageDetails({
    required this.packageId,
    required this.packageName,
    required this.packagePrice,
  });

  final String packageId;
  final String packageName;
  final String packagePrice;

  factory PackageDetails.fromJson(Map<String, dynamic> json) => PackageDetails(
        packageId: json["package_id"],
        packageName: json["package_name"],
        packagePrice: json["package_price"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "package_name": packageName,
        "package_price": packagePrice,
      };
}

class PatientDetails {
  PatientDetails({
    required this.patientName,
    required this.patientNo,
  });

  final String patientName;
  final String patientNo;

  factory PatientDetails.fromJson(Map<String, dynamic> json) => PatientDetails(
        patientName: json["patient_name"],
        patientNo: json["patient_no"],
      );

  Map<String, dynamic> toJson() => {
        "patient_name": patientName,
        "patient_no": patientNo,
      };
}
