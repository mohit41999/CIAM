// To parse this JSON data, do
//
//     final allTestModel = allTestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllTestModel allTestModelFromJson(String str) =>
    AllTestModel.fromJson(json.decode(str));

String allTestModelToJson(AllTestModel data) => json.encode(data.toJson());

class AllTestModel {
  AllTestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory AllTestModel.fromJson(Map<String, dynamic> json) => AllTestModel(
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
    required this.id,
    required this.testName,
    required this.testDescription,
  });

  String id;
  String testName;
  String testDescription;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        testName: json["test_name"],
        testDescription: json["test_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "test_name": testName,
        "test_description": testDescription,
      };
}
