// To parse this JSON data, do
//
//     final hospitalPackagesCatModel = hospitalPackagesCatModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HospitalPackagesCatModel hospitalPackagesCatModelFromJson(String str) =>
    HospitalPackagesCatModel.fromJson(json.decode(str));

String hospitalPackagesCatModelToJson(HospitalPackagesCatModel data) =>
    json.encode(data.toJson());

class HospitalPackagesCatModel {
  HospitalPackagesCatModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<HospitalPackagesCatModelData> data;

  factory HospitalPackagesCatModel.fromJson(Map<String, dynamic> json) =>
      HospitalPackagesCatModel(
        status: json["status"],
        message: json["message"],
        data: List<HospitalPackagesCatModelData>.from(
            json["data"].map((x) => HospitalPackagesCatModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HospitalPackagesCatModelData {
  HospitalPackagesCatModelData({
    required this.serviceId,
    required this.serviceName,
    required this.image,
  });

  final String serviceId;
  final String serviceName;
  final String image;

  factory HospitalPackagesCatModelData.fromJson(Map<String, dynamic> json) =>
      HospitalPackagesCatModelData(
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
