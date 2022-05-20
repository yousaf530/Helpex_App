import 'dart:convert';

class Appointment {
  String advisorUid = "";
  String adviseeUid = "";
  String meetingTime = "";
  String meetingCost = "";
  Appointment({
    required this.advisorUid,
    required this.adviseeUid,
    required this.meetingTime,
    required this.meetingCost,
  });

  Appointment copyWith({
    String? advisorUid,
    String? adviseeUid,
    String? meetingTime,
    String? meetingCost,
  }) {
    return Appointment(
      advisorUid: advisorUid ?? this.advisorUid,
      adviseeUid: adviseeUid ?? this.adviseeUid,
      meetingTime: meetingTime ?? this.meetingTime,
      meetingCost: meetingCost ?? this.meetingCost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'advisorUid': advisorUid,
      'adviseeUid': adviseeUid,
      'meetingTime': meetingTime,
      'meetingCost': meetingCost,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      advisorUid: map['advisorUid'] ?? '',
      adviseeUid: map['adviseeUid'] ?? '',
      meetingTime: map['meetingTime'] ?? '',
      meetingCost: map['meetingCost'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) => Appointment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Appointment(advisorUid: $advisorUid, adviseeUid: $adviseeUid, meetingTime: $meetingTime, meetingCost: $meetingCost)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Appointment &&
      other.advisorUid == advisorUid &&
      other.adviseeUid == adviseeUid &&
      other.meetingTime == meetingTime &&
      other.meetingCost == meetingCost;
  }

  @override
  int get hashCode {
    return advisorUid.hashCode ^
      adviseeUid.hashCode ^
      meetingTime.hashCode ^
      meetingCost.hashCode;
  }
}
