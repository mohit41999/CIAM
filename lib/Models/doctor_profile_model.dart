// To parse this JSON data, do
//
//     final doctorProfileModel = doctorProfileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DoctorProfileModel doctorProfileModelFromJson(String str) =>
    DoctorProfileModel.fromJson(json.decode(str));

String doctorProfileModelToJson(DoctorProfileModel data) =>
    json.encode(data.toJson());

class DoctorProfileModel {
  DoctorProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<DoctorProfileModelData> data;

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) =>
      DoctorProfileModel(
        status: json["status"],
        message: json["message"],
        data: List<DoctorProfileModelData>.from(
            json["data"].map((x) => DoctorProfileModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DoctorProfileModelData {
  DoctorProfileModelData({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.specialist,
    required this.specialistId,
    required this.experience,
    required this.location,
    required this.available,
    required this.gender,
    required this.fees,
    required this.profileImage,
  });

  String userId;
  String firstName;
  String lastName;
  String specialist;
  String specialistId;
  String experience;
  String location;
  String available;
  String gender;
  String fees;
  String profileImage;

  factory DoctorProfileModelData.fromJson(Map<String, dynamic> json) =>
      DoctorProfileModelData(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        specialist: json["specialist"],
        specialistId: json["specialist_id"],
        experience: json["experience"],
        location: json["location"],
        available: json["available"],
        gender: json["gender"],
        fees: json["fees"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "specialist": specialist,
        "specialist_id": specialistId,
        "experience": experience,
        "location": location,
        "available": available,
        "gender": gender,
        "fees": fees,
        "profile_image": profileImage,
      };
}
