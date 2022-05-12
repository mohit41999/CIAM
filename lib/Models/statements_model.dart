// To parse this JSON data, do
//
//     final statementsModel = statementsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StatementsModel statementsModelFromJson(String str) =>
    StatementsModel.fromJson(json.decode(str));

String statementsModelToJson(StatementsModel data) =>
    json.encode(data.toJson());

class StatementsModel {
  StatementsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<StatementsModelData> data;

  factory StatementsModel.fromJson(Map<String, dynamic> json) =>
      StatementsModel(
        status: json["status"],
        message: json["message"],
        data: List<StatementsModelData>.from(
            json["data"].map((x) => StatementsModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StatementsModelData {
  StatementsModelData({
    required this.statementId,
    required this.statement,
    required this.date,
  });

  final String statementId;
  final String statement;
  final DateTime date;

  factory StatementsModelData.fromJson(Map<String, dynamic> json) =>
      StatementsModelData(
        statementId: json["statement_id"],
        statement: json["statement"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "statement_id": statementId,
        "statement": statement,
        "date": date.toIso8601String(),
      };
}
