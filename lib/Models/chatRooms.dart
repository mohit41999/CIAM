// To parse this JSON data, do
//
//     final chatRooms = chatRoomsFromJson(jsonString);

import 'dart:convert';

ChatRooms chatRoomsFromJson(String str) => ChatRooms.fromJson(json.decode(str));

String chatRoomsToJson(ChatRooms data) => json.encode(data.toJson());

class ChatRooms {
  ChatRooms({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ChatRooms.fromJson(Map<String, dynamic> json) => ChatRooms(
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
    required this.userId,
    required this.userName,
    required this.message,
    required this.profileImage,
  });

  String userId;
  String userName;
  String message;
  String profileImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        userName: json["user_name"],
        message: json["message"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "message": message,
        "profile_image": profileImage,
      };
}
