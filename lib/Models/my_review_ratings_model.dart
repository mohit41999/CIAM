// To parse this JSON data, do
//
//     final myReviewRatingModel = myReviewRatingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyReviewRatingModel myReviewRatingModelFromJson(String str) =>
    MyReviewRatingModel.fromJson(json.decode(str));

String myReviewRatingModelToJson(MyReviewRatingModel data) =>
    json.encode(data.toJson());

class MyReviewRatingModel {
  MyReviewRatingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory MyReviewRatingModel.fromJson(Map<String, dynamic> json) =>
      MyReviewRatingModel(
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
    required this.reviewId,
    required this.doctorId,
    required this.doctorName,
    required this.review,
    required this.rating,
    required this.date,
    required this.profileImage,
  });

  String reviewId;
  String doctorId;
  String doctorName;
  String review;
  String rating;
  String date;
  String profileImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        reviewId: json["review_id"],
        doctorId: json["doctor_id"],
        doctorName: json["doctor_name"],
        review: json["review"],
        rating: json["rating"],
        date: json["date"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "doctor_id": doctorId,
        "doctor_name": doctorName,
        "review": review,
        "rating": rating,
        "date": date,
        "profile_image": profileImage,
      };
}
