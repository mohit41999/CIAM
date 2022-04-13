// To parse this JSON data, do
//
//     final labDetailsModel = labDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LabDetailsModel labDetailsModelFromJson(String str) =>
    LabDetailsModel.fromJson(json.decode(str));

String labDetailsModelToJson(LabDetailsModel data) =>
    json.encode(data.toJson());

class LabDetailsModel {
  LabDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory LabDetailsModel.fromJson(Map<String, dynamic> json) =>
      LabDetailsModel(
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
    required this.labId,
    required this.labName,
    required this.labImage,
    required this.email,
    required this.mobileNo,
    required this.city,
    required this.address,
  });

  String labId;
  String labName;
  String labImage;
  String email;
  String mobileNo;
  String city;
  String address;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        labId: json["lab_id"],
        labName: json["lab_name"],
        labImage: json["lab_image"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        city: json["city"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "lab_id": labId,
        "lab_name": labName,
        "lab_image": labImage,
        "email": email,
        "mobile_no": mobileNo,
        "city": city,
        "address": address,
      };
}
