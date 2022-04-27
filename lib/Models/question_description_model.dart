// To parse this JSON data, do
//
//     final questionDescriptionAnswerModel = questionDescriptionAnswerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

QuestionDescriptionAnswerModel questionDescriptionAnswerModelFromJson(
        String str) =>
    QuestionDescriptionAnswerModel.fromJson(json.decode(str));

String questionDescriptionAnswerModelToJson(
        QuestionDescriptionAnswerModel data) =>
    json.encode(data.toJson());

class QuestionDescriptionAnswerModel {
  QuestionDescriptionAnswerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory QuestionDescriptionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionDescriptionAnswerModel(
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
    required this.questionId,
    required this.questoin,
    required this.description,
    required this.answers,
  });

  final String questionId;
  final String questoin;
  final String description;
  final List<Answer> answers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        questionId: json["question_id"],
        questoin: json["questoin"],
        description: json["description"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "questoin": questoin,
        "description": description,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class Answer {
  Answer({
    required this.doctorName,
    required this.answer,
    required this.date,
  });

  final String doctorName;
  final String answer;
  final DateTime date;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        doctorName: json["doctor_name"],
        answer: json["Answer"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "doctor_name": doctorName,
        "Answer": answer,
        "date": date.toIso8601String(),
      };
}
