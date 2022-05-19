// To parse this JSON data, do
//
//     final organCategroiesModel = organCategroiesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrganCategroiesModel organCategroiesModelFromJson(String str) =>
    OrganCategroiesModel.fromJson(json.decode(str));

String organCategroiesModelToJson(OrganCategroiesModel data) =>
    json.encode(data.toJson());

class OrganCategroiesModel {
  OrganCategroiesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<OrganCategroiesModelData> data;

  factory OrganCategroiesModel.fromJson(Map<String, dynamic> json) =>
      OrganCategroiesModel(
        status: json["status"],
        message: json["message"],
        data: List<OrganCategroiesModelData>.from(
            json["data"].map((x) => OrganCategroiesModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrganCategroiesModelData {
  OrganCategroiesModelData({
    required this.organId,
    required this.organName,
    required this.image,
  });

  final String organId;
  final String organName;
  final String image;

  factory OrganCategroiesModelData.fromJson(Map<String, dynamic> json) =>
      OrganCategroiesModelData(
        organId: json["organ_id"],
        organName: json["organ_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "organ_id": organId,
        "organ_name": organName,
        "image": image,
      };
}
