// To parse this JSON data, do
//
//     final allPackagesModel = allPackagesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllPackagesModel allPackagesModelFromJson(String str) =>
    AllPackagesModel.fromJson(json.decode(str));

String allPackagesModelToJson(AllPackagesModel data) =>
    json.encode(data.toJson());

class AllPackagesModel {
  AllPackagesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory AllPackagesModel.fromJson(Map<String, dynamic> json) =>
      AllPackagesModel(
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
    required this.packgeId,
    required this.packgeName,
    required this.labTest,
  });

  String packgeId;
  String packgeName;

  List<LabTest> labTest;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    required this.test,
    required this.testName,
  });

  String test;
  String testName;

  factory LabTest.fromJson(Map<String, dynamic> json) => LabTest(
        test: json["test"],
        testName: json["test_name"],
      );

  Map<String, dynamic> toJson() => {
        "test": test,
        "test_name": testName,
      };
}
