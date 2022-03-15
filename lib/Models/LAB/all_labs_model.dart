// To parse this JSON data, do
//
//     final allLabsModel = allLabsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllLabsModel allLabsModelFromJson(String str) => AllLabsModel.fromJson(json.decode(str));

String allLabsModelToJson(AllLabsModel data) => json.encode(data.toJson());

class AllLabsModel {
  AllLabsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory AllLabsModel.fromJson(Map<String, dynamic> json) => AllLabsModel(
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
    required this.labname,
    required this.location,
    required this.image,
  });

  String labId;
  String labname;
  String location;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    labId: json["lab_id"],
    labname: json["labname"],
    location: json["location"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "lab_id": labId,
    "labname": labname,
    "location": location,
    "image": image,
  };
}
