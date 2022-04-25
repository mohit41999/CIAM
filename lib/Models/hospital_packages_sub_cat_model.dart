// To parse this JSON data, do
//
//     final hospitalPackagesSubCatModel = hospitalPackagesSubCatModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HospitalPackagesSubCatModel hospitalPackagesSubCatModelFromJson(String str) =>
    HospitalPackagesSubCatModel.fromJson(json.decode(str));

String hospitalPackagesSubCatModelToJson(HospitalPackagesSubCatModel data) =>
    json.encode(data.toJson());

class HospitalPackagesSubCatModel {
  HospitalPackagesSubCatModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory HospitalPackagesSubCatModel.fromJson(Map<String, dynamic> json) =>
      HospitalPackagesSubCatModel(
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
    required this.subPackageId,
    required this.hospitalPackageId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  final String subPackageId;
  final String hospitalPackageId;
  final String name;
  final String image;
  final String description;
  final String price;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subPackageId: json["sub_package_id"],
        hospitalPackageId: json["hospital_package_id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "sub_package_id": subPackageId,
        "hospital_package_id": hospitalPackageId,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
      };
}
