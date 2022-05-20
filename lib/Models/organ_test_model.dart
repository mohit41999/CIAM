// To parse this JSON data, do
//
//     final organTestModel = organTestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrganTestModel organTestModelFromJson(String str) =>
    OrganTestModel.fromJson(json.decode(str));

String organTestModelToJson(OrganTestModel data) => json.encode(data.toJson());

class OrganTestModel {
  OrganTestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory OrganTestModel.fromJson(Map<String, dynamic> json) => OrganTestModel(
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
  Datum({
    required this.testId,
    required this.testName,
    required this.testDescription,
  });

  final String testId;
  final String testName;
  final String testDescription;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        testId: json["test_id"],
        testDescription: json["test_description"],
        testName: json["test_name"],
      );

  Map<String, dynamic> toJson() => {
        "test_id": testId,
        "test_description": testDescription,
        "test_name": testName,
      };
}
