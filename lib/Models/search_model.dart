// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<SearchModelData> data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        status: json["status"],
        message: json["message"],
        data: List<SearchModelData>.from(
            json["data"].map((x) => SearchModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchModelData {
  SearchModelData({
    required this.doctorId,
    required this.doctorName,
  });

  String doctorId;
  String doctorName;

  factory SearchModelData.fromJson(Map<String, dynamic> json) =>
      SearchModelData(
        doctorId: json["Doctor id"],
        doctorName: json["Doctor Name"],
      );

  Map<String, dynamic> toJson() => {
        "Doctor id": doctorId,
        "Doctor Name": doctorName,
      };
}
