// To parse this JSON data, do
//
//     final medicineProfileModel = medicineProfileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MedicineProfileModel medicineProfileModelFromJson(String str) =>
    MedicineProfileModel.fromJson(json.decode(str));

String medicineProfileModelToJson(MedicineProfileModel data) =>
    json.encode(data.toJson());

class MedicineProfileModel {
  MedicineProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<MedicineProfileModelDatum> data;

  factory MedicineProfileModel.fromJson(Map<String, dynamic> json) =>
      MedicineProfileModel(
        status: json["status"],
        message: json["message"],
        data: List<MedicineProfileModelDatum>.from(
            json["data"].map((x) => MedicineProfileModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MedicineProfileModelDatum {
  MedicineProfileModelDatum({
    required this.medicinesName,
    required this.price,
    required this.description,
    required this.medicineImage,
  });

  String medicinesName;
  String price;
  String description;
  String medicineImage;

  factory MedicineProfileModelDatum.fromJson(Map<String, dynamic> json) =>
      MedicineProfileModelDatum(
        medicinesName: json["medicines_name"],
        price: json["price"],
        description: json["description"],
        medicineImage: json["medicine_image"],
      );

  Map<String, dynamic> toJson() => {
        "medicines_name": medicinesName,
        "price": price,
        "description": description,
        "medicine_image": medicineImage,
      };
}
