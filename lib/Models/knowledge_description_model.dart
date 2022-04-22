// To parse this JSON data, do
//
//     final knowledgeDescriptionModel = knowledgeDescriptionModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KnowledgeDescriptionModel knowledgeDescriptionModelFromJson(String str) =>
    KnowledgeDescriptionModel.fromJson(json.decode(str));

String knowledgeDescriptionModelToJson(KnowledgeDescriptionModel data) =>
    json.encode(data.toJson());

class KnowledgeDescriptionModel {
  KnowledgeDescriptionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory KnowledgeDescriptionModel.fromJson(Map<String, dynamic> json) =>
      KnowledgeDescriptionModel(
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
    required this.forumId,
    required this.knowledgeTitle,
    required this.knowledgeDescription,
    required this.date,
  });

  final String forumId;
  final String knowledgeTitle;
  final String knowledgeDescription;
  final DateTime date;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        forumId: json["forum_id"],
        knowledgeTitle: json["knowledge_title"],
        knowledgeDescription: json["knowledge_description"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "forum_id": forumId,
        "knowledge_title": knowledgeTitle,
        "knowledge_description": knowledgeDescription,
        "date": date.toIso8601String(),
      };
}
