// To parse this JSON data, do
//
//     final docReviewModel = docReviewModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DocReviewModel docReviewModelFromJson(String str) =>
    DocReviewModel.fromJson(json.decode(str));

String docReviewModelToJson(DocReviewModel data) => json.encode(data.toJson());

class DocReviewModel {
  DocReviewModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory DocReviewModel.fromJson(Map<String, dynamic> json) => DocReviewModel(
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
    required this.userDetails,
    required this.message,
    required this.rating,
    required this.date,
  });

  UserDetails userDetails;
  String message;
  String rating;
  String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userDetails: UserDetails.fromJson(json["user_details"]),
        message: json["message"],
        rating: json["rating"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "user_details": userDetails.toJson(),
        "message": message,
        "rating": rating,
        "date": date,
      };
}

class UserDetails {
  UserDetails({
    required this.patientId,
    required this.patientName,
    required this.patientImage,
  });

  String patientId;
  String patientName;
  String patientImage;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        patientId: json["patient_id"],
        patientName: json["patient_name"],
        patientImage: json["patient_image"],
      );

  Map<String, dynamic> toJson() => {
        "patient_id": patientId,
        "patient_name": patientName,
        "patient_image": patientImage,
      };
}
