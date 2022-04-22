// To parse this JSON data, do
//
//     final knowledgeForumModel = knowledgeForumModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

KnowledgeForumModel knowledgeForumModelFromJson(String str) =>
    KnowledgeForumModel.fromJson(json.decode(str));

String knowledgeForumModelToJson(KnowledgeForumModel data) =>
    json.encode(data.toJson());

class KnowledgeForumModel {
  KnowledgeForumModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory KnowledgeForumModel.fromJson(Map<String, dynamic> json) =>
      KnowledgeForumModel(
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
    required this.forumId,
    required this.knowledgeTitle,
    required this.doctorName,
    required this.date,
  });

  final String forumId;
  final String knowledgeTitle;
  final String doctorName;
  final DateTime date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        forumId: json["forum_id"],
        knowledgeTitle: json["knowledge_title"],
        doctorName: json["doctor_name"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "forum_id": forumId,
        "knowledge_title": knowledgeTitle,
        "doctor_name": doctorName,
        "date": date.toIso8601String(),
      };
}
