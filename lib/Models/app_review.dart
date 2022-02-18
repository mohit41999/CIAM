// To parse this JSON data, do
//
//     final appReviewModel = appReviewModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AppReviewModel appReviewModelFromJson(String str) =>
    AppReviewModel.fromJson(json.decode(str));

String appReviewModelToJson(AppReviewModel data) => json.encode(data.toJson());

class AppReviewModel {
  AppReviewModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<AppReviewData> data;

  factory AppReviewModel.fromJson(Map<String, dynamic> json) => AppReviewModel(
        status: json["status"],
        message: json["message"],
        data: List<AppReviewData>.from(
            json["data"].map((x) => AppReviewData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AppReviewData {
  AppReviewData({
    required this.userName,
    required this.review,
    required this.rating,
    required this.date,
  });

  String userName;
  String review;
  String rating;
  String date;

  factory AppReviewData.fromJson(Map<String, dynamic> json) => AppReviewData(
        userName: json["userName"],
        review: json["review"],
        rating: json["rating"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "review": review,
        "rating": rating,
        "date": date,
      };
}
