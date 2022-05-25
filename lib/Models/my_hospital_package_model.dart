// To parse this JSON data, do
//
//     final myHospitalPackageModel = myHospitalPackageModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyHospitalPackageModel myHospitalPackageModelFromJson(String str) =>
    MyHospitalPackageModel.fromJson(json.decode(str));

String myHospitalPackageModelToJson(MyHospitalPackageModel data) =>
    json.encode(data.toJson());

class MyHospitalPackageModel {
  MyHospitalPackageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<MyHospitalPackageModelData> data;

  factory MyHospitalPackageModel.fromJson(Map<String, dynamic> json) =>
      MyHospitalPackageModel(
        status: json["status"],
        message: json["message"],
        data: List<MyHospitalPackageModelData>.from(
            json["data"].map((x) => MyHospitalPackageModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyHospitalPackageModelData {
  MyHospitalPackageModelData({
    required this.booingId,
    required this.packageCategory,
    required this.packageSubCategory,
    required this.date,
  });

  final String booingId;
  final String packageCategory;
  final String packageSubCategory;
  final String date;

  factory MyHospitalPackageModelData.fromJson(Map<String, dynamic> json) =>
      MyHospitalPackageModelData(
        booingId: json["booing_id"],
        packageCategory: json["package_category"],
        packageSubCategory: json["package_sub_category"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "booing_id": booingId,
        "package_category": packageCategory,
        "package_sub_category": packageSubCategory,
        "date": date,
      };
}
