// To parse this JSON data, do
//
//     final askQuestionModel = askQuestionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AskQuestionModel askQuestionModelFromJson(String str) =>
    AskQuestionModel.fromJson(json.decode(str));

String askQuestionModelToJson(AskQuestionModel data) =>
    json.encode(data.toJson());

class AskQuestionModel {
  AskQuestionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<AskQuestionModelData> data;

  factory AskQuestionModel.fromJson(Map<String, dynamic> json) =>
      AskQuestionModel(
        status: json["status"],
        message: json["message"],
        data: List<AskQuestionModelData>.from(
            json["data"].map((x) => AskQuestionModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AskQuestionModelData {
  AskQuestionModelData({
    required this.questionId,
    required this.question,
    required this.category_name,
    required this.description,
    required this.createdDate,
  });

  final String questionId;
  final String question;
  final String description;
  final String category_name;
  final DateTime createdDate;

  factory AskQuestionModelData.fromJson(Map<String, dynamic> json) =>
      AskQuestionModelData(
        questionId: json["question_id"],
        question: json["question"],
        category_name: json["category_name"],
        description: json["description"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question": question,
        "category_name": category_name,
        "description": description,
        "created_date": createdDate.toIso8601String(),
      };
}
