// To parse this JSON data, do
//
//     final searchAskQuestionModel = searchAskQuestionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchAskQuestionModel searchAskQuestionModelFromJson(String str) =>
    SearchAskQuestionModel.fromJson(json.decode(str));

String searchAskQuestionModelToJson(SearchAskQuestionModel data) =>
    json.encode(data.toJson());

class SearchAskQuestionModel {
  SearchAskQuestionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory SearchAskQuestionModel.fromJson(Map<String, dynamic> json) =>
      SearchAskQuestionModel(
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
    required this.questionId,
    required this.questionTitle,
  });

  final String questionId;
  final String questionTitle;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        questionId: json["question_id"],
        questionTitle: json["question_title"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question_title": questionTitle,
      };
}
