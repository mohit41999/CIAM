// To parse this JSON data, do
//
//     final slotTime = slotTimeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SlotTime slotTimeFromJson(String str) => SlotTime.fromJson(json.decode(str));

String slotTimeToJson(SlotTime data) => json.encode(data.toJson());

class SlotTime {
  SlotTime({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  SlotTimeData data;

  factory SlotTime.fromJson(Map<String, dynamic> json) => SlotTime(
        status: json["status"],
        message: json["message"],
        data: SlotTimeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class SlotTimeData {
  SlotTimeData({
    required this.timeSlot,
  });

  List<TimeSlot> timeSlot;

  factory SlotTimeData.fromJson(Map<String, dynamic> json) => SlotTimeData(
        timeSlot: List<TimeSlot>.from(
            json["Time Slot"].map((x) => TimeSlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Time Slot": List<dynamic>.from(timeSlot.map((x) => x.toJson())),
      };
}

class TimeSlot {
  TimeSlot({
    required this.slotTime,
    required this.status,
  });

  dynamic slotTime;
  String status;

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        slotTime: json["slot_time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "slot_time": slotTime,
        "status": status,
      };
}
