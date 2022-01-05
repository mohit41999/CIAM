// To parse this JSON data, do
//
//     final getPatientMedical = getPatientMedicalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetPatientMedical getPatientMedicalFromJson(String str) =>
    GetPatientMedical.fromJson(json.decode(str));

String getPatientMedicalToJson(GetPatientMedical data) =>
    json.encode(data.toJson());

class GetPatientMedical {
  GetPatientMedical({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetPatientMedical.fromJson(Map<String, dynamic> json) =>
      GetPatientMedical(
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
    required this.detailsOfAllergies,
    required this.currentAndPastMedication,
    required this.pastSurgeryInjury,
    required this.chronicDisease,
  });

  String userId;
  String detailsOfAllergies;
  String currentAndPastMedication;
  String pastSurgeryInjury;
  String chronicDisease;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        detailsOfAllergies: json["details_of_allergies"],
        currentAndPastMedication: json["current_and_past_medication"],
        pastSurgeryInjury: json["past_surgery_injury"],
        chronicDisease: json["chronic_disease"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "details_of_allergies": detailsOfAllergies,
        "current_and_past_medication": currentAndPastMedication,
        "past_surgery_injury": pastSurgeryInjury,
        "chronic_disease": chronicDisease,
      };
}
