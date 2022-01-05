// To parse this JSON data, do
//
//     final getPatientLifeStyle = getPatientLifeStyleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetPatientLifeStyle getPatientLifeStyleFromJson(String str) =>
    GetPatientLifeStyle.fromJson(json.decode(str));

String getPatientLifeStyleToJson(GetPatientLifeStyle data) =>
    json.encode(data.toJson());

class GetPatientLifeStyle {
  GetPatientLifeStyle({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetPatientLifeStyle.fromJson(Map<String, dynamic> json) =>
      GetPatientLifeStyle(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.smoking,
    required this.alchol,
    required this.workoutLevel,
    required this.sportsInvolvement,
  });

  String userId;
  String smoking;
  String alchol;
  String workoutLevel;
  String sportsInvolvement;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        smoking: json["smoking"],
        alchol: json["alchol"],
        workoutLevel: json["workout_level"],
        sportsInvolvement: json["sports_involvement"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "smoking": smoking,
        "alchol": alchol,
        "workout_level": workoutLevel,
        "sports_involvement": sportsInvolvement,
      };
}
