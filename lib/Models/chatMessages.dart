// To parse this JSON data, do
//
//     final chatMessages = chatMessagesFromJson(jsonString);

import 'dart:convert';

ChatMessages chatMessagesFromJson(String str) =>
    ChatMessages.fromJson(json.decode(str));

String chatMessagesToJson(ChatMessages data) => json.encode(data.toJson());

class ChatMessages {
  ChatMessages({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ChatMessages.fromJson(Map<String, dynamic> json) => ChatMessages(
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
    required this.doctorId,
    required this.patientId,
    required this.sendBy,
    required this.message,
    required this.chatImage,
    required this.chatVideo,
    required this.date,
    required this.time,
  });

  String doctorId;
  String patientId;
  String sendBy;
  String message;
  String chatImage;
  String chatVideo;
  String date;
  String time;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        doctorId: json["doctor_id"],
        patientId: json["patient_id"],
        sendBy: json["send_by"],
        message: json["message"],
        chatImage: json["chat_image"],
        chatVideo: json["chat_video"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "patient_id": patientId,
        "send_by": sendBy,
        "message": message,
        "chat_image": chatImage,
        "chat_video": chatVideo,
        "date": date,
        "time": time,
      };
}
