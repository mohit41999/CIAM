// To parse this JSON data, do
//
//     final homeCareCategoriesModel = homeCareCategoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HealthCareCategoriesModel homeCareCategoriesModelFromJson(String str) =>
    HealthCareCategoriesModel.fromJson(json.decode(str));

String homeCareCategoriesModelToJson(HealthCareCategoriesModel data) =>
    json.encode(data.toJson());

class HealthCareCategoriesModel {
  HealthCareCategoriesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<HealthCareCategoriesModelData> data;

  factory HealthCareCategoriesModel.fromJson(Map<String, dynamic> json) =>
      HealthCareCategoriesModel(
        status: json["status"],
        message: json["message"],
        data: List<HealthCareCategoriesModelData>.from(
            json["data"].map((x) => HealthCareCategoriesModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HealthCareCategoriesModelData {
  HealthCareCategoriesModelData({
    required this.serviceId,
    required this.serviceName,
    required this.image,
  });

  String serviceId;
  String serviceName;
  String image;

  factory HealthCareCategoriesModelData.fromJson(Map<String, dynamic> json) =>
      HealthCareCategoriesModelData(
        serviceId: json["Service_id"],
        serviceName: json["Service Name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "Service_id": serviceId,
        "Service Name": serviceName,
        "image": image,
      };
}
