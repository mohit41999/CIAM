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
  List<Datum> data;

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) =>
      DoctorProfileModel(
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
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.specialist,
    required this.experience,
    required this.location,
    required this.profileImage,
    required this.available,
  });

  String userId;
  String firstName;
  String lastName;
  dynamic specialist;
  String experience;
  String available;
  String location;
  String profileImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        specialist: json["specialist"],
        experience: json["experience"],
        location: json["location"],
        profileImage: json["profile_image"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "specialist": specialist,
        "experience": experience,
        "location": location,
        "profile_image": profileImage,
        "available": available,
      };
}
