// To parse this JSON data, do
//
//     final homeCareSubCategoriesModel = homeCareSubCategoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HomeCareSubCategoriesModel homeCareSubCategoriesModelFromJson(String str) =>
    HomeCareSubCategoriesModel.fromJson(json.decode(str));

String homeCareSubCategoriesModelToJson(HomeCareSubCategoriesModel data) =>
    json.encode(data.toJson());

class HomeCareSubCategoriesModel {
  HomeCareSubCategoriesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory HomeCareSubCategoriesModel.fromJson(Map<String, dynamic> json) =>
      HomeCareSubCategoriesModel(
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
    required this.subCareId,
    required this.homeCareId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  String subCareId;
  String homeCareId;
  String name;
  String image;
  String description;
  String price;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subCareId: json["sub_care_id"],
        homeCareId: json["home_care_id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "sub_care_id": subCareId,
        "home_care_id": homeCareId,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
      };
}
