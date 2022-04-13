// To parse this JSON data, do
//
//     final packageAvailableLabModel = packageAvailableLabModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PackageAvailableLabModel packageAvailableLabModelFromJson(String str) =>
    PackageAvailableLabModel.fromJson(json.decode(str));

String packageAvailableLabModelToJson(PackageAvailableLabModel data) =>
    json.encode(data.toJson());

class PackageAvailableLabModel {
  PackageAvailableLabModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory PackageAvailableLabModel.fromJson(Map<String, dynamic> json) =>
      PackageAvailableLabModel(
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
    required this.packagePrice,
  });

  final String labId;
  final String labName;
  final String labImage;
  final String packagePrice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        labId: json["lab_id"],
        labName: json["lab_name"],
        labImage: json["lab_image"],
        packagePrice: json["package_price"],
      );

  Map<String, dynamic> toJson() => {
        "lab_id": labId,
        "lab_name": labName,
        "lab_image": labImage,
        "package_price": packagePrice,
      };
}
