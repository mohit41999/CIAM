// To parse this JSON data, do
//
//     final testAvailableLabsModel = testAvailableLabsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TestAvailableLabsModel testAvailableLabsModelFromJson(String str) =>
    TestAvailableLabsModel.fromJson(json.decode(str));

String testAvailableLabsModelToJson(TestAvailableLabsModel data) =>
    json.encode(data.toJson());

class TestAvailableLabsModel {
  TestAvailableLabsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory TestAvailableLabsModel.fromJson(Map<String, dynamic> json) =>
      TestAvailableLabsModel(
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
    required this.labId,
    required this.labName,
    required this.labImage,
    required this.testPrice,
  });

  String labId;
  String labName;
  String labImage;
  String testPrice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        labId: json["lab_id"],
        labName: json["lab_name"],
        labImage: json["lab_image"],
        testPrice: json["test_price"],
      );

  Map<String, dynamic> toJson() => {
        "lab_id": labId,
        "lab_name": labName,
        "lab_image": labImage,
        "test_price": testPrice,
      };
}
