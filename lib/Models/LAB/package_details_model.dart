// To parse this JSON data, do
//
//     final packageDetailsModel = packageDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PackageDetailsModel packageDetailsModelFromJson(String str) =>
    PackageDetailsModel.fromJson(json.decode(str));

String packageDetailsModelToJson(PackageDetailsModel data) =>
    json.encode(data.toJson());

class PackageDetailsModel {
  PackageDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory PackageDetailsModel.fromJson(Map<String, dynamic> json) =>
      PackageDetailsModel(
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
    required this.packgeId,
    required this.packgeName,
    required this.labTest,
  });

  final String packgeId;
  final String packgeName;
  final List<LabTest> labTest;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        packgeId: json["packge_id"],
        packgeName: json["packge_name"],
        labTest: List<LabTest>.from(
            json["lab_test"].map((x) => LabTest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "packge_id": packgeId,
        "packge_name": packgeName,
        "lab_test": List<dynamic>.from(labTest.map((x) => x.toJson())),
      };
}

class LabTest {
  LabTest({
    required this.testId,
    required this.testName,
  });

  final String testId;
  final String testName;

  factory LabTest.fromJson(Map<String, dynamic> json) => LabTest(
        testId: json["test_id"],
        testName: json["test_name"],
      );

  Map<String, dynamic> toJson() => {
        "test_id": testId,
        "test_name": testName,
      };
}
