// To parse this JSON data, do
//
//     final homeDoctorSpecialityModel = homeDoctorSpecialityModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HomeDoctorSpecialityModel homeDoctorSpecialityModelFromJson(String str) =>
    HomeDoctorSpecialityModel.fromJson(json.decode(str));

String homeDoctorSpecialityModelToJson(HomeDoctorSpecialityModel data) =>
    json.encode(data.toJson());

class HomeDoctorSpecialityModel {
  HomeDoctorSpecialityModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<HomeDoctorSpecialityModelDatum> data;

  factory HomeDoctorSpecialityModel.fromJson(Map<String, dynamic> json) =>
      HomeDoctorSpecialityModel(
        status: json["status"],
        message: json["message"],
        data: List<HomeDoctorSpecialityModelDatum>.from(json["data"]
            .map((x) => HomeDoctorSpecialityModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HomeDoctorSpecialityModelDatum {
  HomeDoctorSpecialityModelDatum({
    required this.specialistId,
    required this.specialistName,
    required this.specialistImg,
  });

  String specialistId;
  String specialistName;
  String specialistImg;

  factory HomeDoctorSpecialityModelDatum.fromJson(Map<String, dynamic> json) =>
      HomeDoctorSpecialityModelDatum(
        specialistId: json["Specialist id"],
        specialistName: json["Specialist Name"],
        specialistImg: json["Specialist img"],
      );

  Map<String, dynamic> toJson() => {
        "Specialist id": specialistId,
        "Specialist Name": specialistName,
        "Specialist img": specialistImg,
      };
}
