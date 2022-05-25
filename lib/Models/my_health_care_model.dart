// To parse this JSON data, do
//
//     final myHealthCareModel = myHealthCareModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyHealthCareModel myHealthCareModelFromJson(String str) => MyHealthCareModel.fromJson(json.decode(str));

String myHealthCareModelToJson(MyHealthCareModel data) => json.encode(data.toJson());

class MyHealthCareModel {
  MyHealthCareModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<MyHealthCareModelDatum> data;

  factory MyHealthCareModel.fromJson(Map<String, dynamic> json) => MyHealthCareModel(
    status: json["status"],
    message: json["message"],
    data: List<MyHealthCareModelDatum>.from(json["data"].map((x) => MyHealthCareModelDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MyHealthCareModelDatum {
  MyHealthCareModelDatum({
    required this.booingId,
    required this.homecareCategory,
    required this.homecareSubCategory,
    required this.date,
  });

  final String booingId;
  final String homecareCategory;
  final String homecareSubCategory;
  final String date;

  factory MyHealthCareModelDatum.fromJson(Map<String, dynamic> json) => MyHealthCareModelDatum(
    booingId: json["booing_id"],
    homecareCategory: json["homecare_category"],
    homecareSubCategory: json["homecare_sub_category"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "booing_id": booingId,
    "homecare_category": homecareCategory,
    "homecare_sub_category": homecareSubCategory,
    "date": date,
  };
}
