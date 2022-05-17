// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Apointments {
  String adviseeName = "";
  String adviseeUid = "";
  String advisorName = "";
  String advisorUid = "";
  String date = "";
  String meetingSlot = "";
  double meetingTimeInMins = 0;
  bool isDone = false;
  Apointments({
    required this.adviseeName,
    required this.adviseeUid,
    required this.advisorName,
    required this.advisorUid,
    required this.date,
    required this.meetingSlot,
    required this.meetingTimeInMins,
    required this.isDone,
  });

  Apointments copyWith({
    String? adviseeName,
    String? adviseeUid,
    String? advisorName,
    String? advisorUid,
    String? date,
    String? meetingSlot,
    double? meetingTimeInMins,
    bool? isDone,
  }) {
    return Apointments(
      adviseeName: adviseeName ?? this.adviseeName,
      adviseeUid: adviseeUid ?? this.adviseeUid,
      advisorName: advisorName ?? this.advisorName,
      advisorUid: advisorUid ?? this.advisorUid,
      date: date ?? this.date,
      meetingSlot: meetingSlot ?? this.meetingSlot,
      meetingTimeInMins: meetingTimeInMins ?? this.meetingTimeInMins,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adviseeName': adviseeName,
      'adviseeUid': adviseeUid,
      'advisorName': advisorName,
      'advisorUid': advisorUid,
      'date': date,
      'meetingSlot': meetingSlot,
      'meetingTimeInMins': meetingTimeInMins,
      'isDone': isDone,
    };
  }

  factory Apointments.fromMap(Map<String, dynamic> map) {
    return Apointments(
      adviseeName: map['adviseeName'] as String,
      adviseeUid: map['adviseeUid'] as String,
      advisorName: map['advisorName'] as String,
      advisorUid: map['advisorUid'] as String,
      date: map['date'] as String,
      meetingSlot: map['meetingSlot'] as String,
      meetingTimeInMins: map['meetingTimeInMins'] as double,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Apointments.fromJson(String source) =>
      Apointments.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Apointments(adviseeName: $adviseeName, adviseeUid: $adviseeUid, advisorName: $advisorName, advisorUid: $advisorUid, date: $date, meetingSlot: $meetingSlot, meetingTimeInMins: $meetingTimeInMins, isDone: $isDone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Apointments &&
        other.adviseeName == adviseeName &&
        other.adviseeUid == adviseeUid &&
        other.advisorName == advisorName &&
        other.advisorUid == advisorUid &&
        other.date == date &&
        other.meetingSlot == meetingSlot &&
        other.meetingTimeInMins == meetingTimeInMins &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return adviseeName.hashCode ^
        adviseeUid.hashCode ^
        advisorName.hashCode ^
        advisorUid.hashCode ^
        date.hashCode ^
        meetingSlot.hashCode ^
        meetingTimeInMins.hashCode ^
        isDone.hashCode;
  }
}
