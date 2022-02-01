// To parse this JSON data, do
//
//     final relativeModel = relativeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RelativeModel relativeModelFromJson(String str) =>
    RelativeModel.fromJson(json.decode(str));

String relativeModelToJson(RelativeModel data) => json.encode(data.toJson());

class RelativeModel {
  RelativeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<RelativeModelData> data;

  factory RelativeModel.fromJson(Map<String, dynamic> json) => RelativeModel(
        status: json["status"],
        message: json["message"],
        data: List<RelativeModelData>.from(
            json["data"].map((x) => RelativeModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RelativeModelData {
  RelativeModelData({
    required this.relativeName,
    required this.relative_id,
    required this.relation,
    required this.age,
    required this.bloodGroup,
    required this.maritalStatus,
    required this.gender,
  });

  String relativeName;
  String relation;
  String relative_id;
  String age;
  String bloodGroup;
  String maritalStatus;
  String gender;

  factory RelativeModelData.fromJson(Map<String, dynamic> json) =>
      RelativeModelData(
        relativeName: json["relative_name"],
        relative_id: json["relative_id"],
        relation: json["relation"],
        age: json["age"],
        bloodGroup: json["blood_group"],
        maritalStatus: json["marital_status"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "relative_name": relativeName,
        "relative_id": relative_id,
        "relation": relation,
        "age": age,
        "blood_group": bloodGroup,
        "marital_status": maritalStatus,
        "gender": gender,
      };
}
