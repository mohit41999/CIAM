// To parse this JSON data, do
//
//     final doctorProfileOneModel = doctorProfileOneModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DoctorProfileOneModel doctorProfileOneModelFromJson(String str) =>
    DoctorProfileOneModel.fromJson(json.decode(str));

String doctorProfileOneModelToJson(DoctorProfileOneModel data) =>
    json.encode(data.toJson());

class DoctorProfileOneModel {
  DoctorProfileOneModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory DoctorProfileOneModel.fromJson(Map<String, dynamic> json) =>
      DoctorProfileOneModel(
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
    required this.doctorDetails,
    required this.clinicDetails,
    required this.clinicImages,
    required this.diseaseArray,
  });

  final DoctorDetails doctorDetails;
  final ClinicDetails clinicDetails;
  final List<ClinicImage> clinicImages;
  final List<DiseaseArray> diseaseArray;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        doctorDetails: DoctorDetails.fromJson(json["Doctor Details"]),
        clinicDetails: ClinicDetails.fromJson(json["Clinic Details"]),
        clinicImages: List<ClinicImage>.from(
            json["Clinic_images"].map((x) => ClinicImage.fromJson(x))),
        diseaseArray: List<DiseaseArray>.from(
            json["diseaseArray"].map((x) => DiseaseArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Doctor Details": doctorDetails.toJson(),
        "Clinic Details": clinicDetails.toJson(),
        "Clinic_images":
            List<dynamic>.from(clinicImages.map((x) => x.toJson())),
        "diseaseArray": List<dynamic>.from(diseaseArray.map((x) => x.toJson())),
      };
}

class ClinicDetails {
  ClinicDetails({
    required this.clinicName,
    required this.location,
    required this.fromToDays,
    required this.openCloseTime,
    required this.oflineConsultancyFees,
    required this.doctorAvailabilityStatus,
  });

  final String clinicName;
  final String location;
  final String fromToDays;
  final String openCloseTime;
  final String oflineConsultancyFees;
  final String doctorAvailabilityStatus;

  factory ClinicDetails.fromJson(Map<String, dynamic> json) => ClinicDetails(
        clinicName: json["clinic_name"],
        location: json["location"],
        fromToDays: json["from_to_days"],
        openCloseTime: json["open_close_time"],
        oflineConsultancyFees: json["ofline_consultancy_fees"],
        doctorAvailabilityStatus: json["doctor_availability_status"],
      );

  Map<String, dynamic> toJson() => {
        "clinic_name": clinicName,
        "location": location,
        "from_to_days": fromToDays,
        "open_close_time": openCloseTime,
        "ofline_consultancy_fees": oflineConsultancyFees,
        "doctor_availability_status": doctorAvailabilityStatus,
      };
}

class ClinicImage {
  ClinicImage({
    required this.clinicImages,
  });

  final String clinicImages;

  factory ClinicImage.fromJson(Map<String, dynamic> json) => ClinicImage(
        clinicImages: json["clinic_images"],
      );

  Map<String, dynamic> toJson() => {
        "clinic_images": clinicImages,
      };
}

class DiseaseArray {
  DiseaseArray({
    required this.diseaseName,
    required this.disease_id,
  });

  final String diseaseName;
  final String disease_id;

  factory DiseaseArray.fromJson(Map<String, dynamic> json) => DiseaseArray(
        diseaseName: json["disease_name"] == null ? null : json["disease_name"],
        disease_id: json["disease_id"] == null ? null : json["disease_id"],
      );

  Map<String, dynamic> toJson() => {
        "disease_name": diseaseName == null ? null : diseaseName,
        "disease_id": disease_id == null ? null : disease_id,
      };
}

class DoctorDetails {
  DoctorDetails({
    required this.doctorName,
    required this.education,
    required this.specialist,
    required this.languageSpoken,
    required this.experience,
    required this.aboutMe,
    required this.profileImage,
  });

  final String doctorName;
  final String education;
  final String specialist;
  final String languageSpoken;
  final String experience;
  final String aboutMe;
  final String profileImage;

  factory DoctorDetails.fromJson(Map<String, dynamic> json) => DoctorDetails(
        doctorName: json["doctor_name"],
        education: json["education"],
        specialist: json["specialist"],
        languageSpoken: json["language_spoken"],
        experience: json["experience"],
        aboutMe: json["about_me"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_name": doctorName,
        "education": education,
        "specialist": specialist,
        "language_spoken": languageSpoken,
        "experience": experience,
        "about_me": aboutMe,
        "profile_image": profileImage,
      };
}
