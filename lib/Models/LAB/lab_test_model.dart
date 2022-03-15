// To parse this JSON data, do
//
//     final labTestsModel = labTestsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LabTestsModel labTestsModelFromJson(String str) =>
    LabTestsModel.fromJson(json.decode(str));

String labTestsModelToJson(LabTestsModel data) => json.encode(data.toJson());

class LabTestsModel {
  LabTestsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory LabTestsModel.fromJson(Map<String, dynamic> json) => LabTestsModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {required this.testId,
      required this.testName,
      required this.testPrice,
      this.isChecked = false});
  bool isChecked;
  String testId;
  String testName;
  String testPrice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        testId: json["test_id"],
        testName: json["test_name"],
        testPrice: json["test_price"],
      );

  Map<String, dynamic> toJson() => {
        "test_id": testId,
        "test_name": testName,
        "test_price": testPrice,
      };
}
