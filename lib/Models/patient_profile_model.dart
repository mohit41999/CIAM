// To parse this JSON data, do
//
//     final getPatientProfile = getPatientProfileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetPatientProfile getPatientProfileFromJson(String str) =>
    GetPatientProfile.fromJson(json.decode(str));

String getPatientProfileToJson(GetPatientProfile data) =>
    json.encode(data.toJson());

class GetPatientProfile {
  GetPatientProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetPatientProfile.fromJson(Map<String, dynamic> json) =>
      GetPatientProfile(
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
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.age,
    required this.gender,
    required this.dob,
    required this.bloodGroup,
    required this.maritalStatus,
    required this.height,
    required this.weight,
    required this.emergencyContact,
    required this.address,
    required this.profile,
  });

  String userId;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String age;
  String gender;
  DateTime dob;
  String bloodGroup;
  String maritalStatus;
  String height;
  String weight;
  String emergencyContact;
  String address;
  String profile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        age: json["age"],
        gender: json["gender"],
        dob: DateTime.parse(json["DOB"]),
        bloodGroup: json["blood_group"],
        maritalStatus: json["marital_status"],
        height: json["height"],
        weight: json["weight"],
        emergencyContact: json["emergency_contact"],
        address: json["Address"],
        profile: json["Profile"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "mobile_number": mobileNumber,
        "age": age,
        "gender": gender,
        "DOB":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "blood_group": bloodGroup,
        "marital_status": maritalStatus,
        "height": height,
        "weight": weight,
        "emergency_contact": emergencyContact,
        "Address": address,
        "Profile": profile,
      };
}
