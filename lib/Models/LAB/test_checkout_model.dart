// To parse this JSON data, do
//
//     final testCheckoutModel = testCheckoutModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TestCheckoutModel testCheckoutModelFromJson(String str) =>
    TestCheckoutModel.fromJson(json.decode(str));

String testCheckoutModelToJson(TestCheckoutModel data) =>
    json.encode(data.toJson());

class TestCheckoutModel {
  TestCheckoutModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory TestCheckoutModel.fromJson(Map<String, dynamic> json) =>
      TestCheckoutModel(
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
    required this.patientDetails,
    required this.labDetails,
    required this.testDtails,
    required this.billSummary,
  });

  final PatientDetails patientDetails;
  final LabDetails labDetails;
  final List<TestDtail> testDtails;
  final BillSummary billSummary;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        patientDetails: PatientDetails.fromJson(json["patient_details"]),
        labDetails: LabDetails.fromJson(json["lab_details"]),
        testDtails: List<TestDtail>.from(
            json["test_dtails"].map((x) => TestDtail.fromJson(x))),
        billSummary: BillSummary.fromJson(json["bill_summary"]),
      );

  Map<String, dynamic> toJson() => {
        "patient_details": patientDetails.toJson(),
        "lab_details": labDetails.toJson(),
        "test_dtails": List<dynamic>.from(testDtails.map((x) => x.toJson())),
        "bill_summary": billSummary.toJson(),
      };
}

class BillSummary {
  BillSummary({
    required this.totalFees,
    required this.ammountPaid,
  });

  final String totalFees;
  final String ammountPaid;

  factory BillSummary.fromJson(Map<String, dynamic> json) => BillSummary(
        totalFees: json["total_fees"],
        ammountPaid: json["ammount_paid"],
      );

  Map<String, dynamic> toJson() => {
        "total_fees": totalFees,
        "ammount_paid": ammountPaid,
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

class TestDtail {
  TestDtail({
    required this.testId,
    required this.testName,
    required this.price,
  });

  final String testId;
  final String testName;
  final String price;

  factory TestDtail.fromJson(Map<String, dynamic> json) => TestDtail(
        testId: json["test_id"],
        testName: json["test_name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "test_id": testId,
        "test_name": testName,
        "price": price,
      };
}
