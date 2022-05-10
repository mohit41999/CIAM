// To parse this JSON data, do
//
//     final askQuestionCategoryModel = askQuestionCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AskQuestionCategoryModel askQuestionCategoryModelFromJson(String str) =>
    AskQuestionCategoryModel.fromJson(json.decode(str));

String askQuestionCategoryModelToJson(AskQuestionCategoryModel data) =>
    json.encode(data.toJson());

class AskQuestionCategoryModel {
  AskQuestionCategoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<AskQuestionCategoryModelData> data;

  factory AskQuestionCategoryModel.fromJson(Map<String, dynamic> json) =>
      AskQuestionCategoryModel(
        status: json["status"],
        message: json["message"],
        data: List<AskQuestionCategoryModelData>.from(
            json["data"].map((x) => AskQuestionCategoryModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AskQuestionCategoryModelData {
  AskQuestionCategoryModelData({
    required this.categoryId,
    required this.categoryName,
  });

  final String categoryId;
  final String categoryName;

  factory AskQuestionCategoryModelData.fromJson(Map<String, dynamic> json) =>
      AskQuestionCategoryModelData(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
