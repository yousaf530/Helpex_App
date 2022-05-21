// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Availability {
  String uid = "";
  String mondayStart = "-";
  String mondayEnd = "-";
  String tuesdayStart = "-";
  String tuesdayEnd = "-";
  String wednesdayStart = "-";
  String wednesdayEnd = "-";
  String thursdayStart = "-";
  String thursdayEnd = "-";
  String fridayStart = "-";
  String fridayEnd = "-";
  String saturdayStart = "-";
  String saturdayEnd = "-";
  String sundayStart = "-";
  String sundayEnd = "-";

  Availability({
    this.uid = "",
    this.mondayStart = "-",
    this.mondayEnd  = "-",
    this.tuesdayStart = "-",
    this.tuesdayEnd = "-",
    this.wednesdayStart = "-",
    this.wednesdayEnd = "-",
    this.thursdayStart = "-",
    this.thursdayEnd = "-",
    this.fridayStart = "-",
    this.fridayEnd = "-",
    this.saturdayStart = "-",
    this.saturdayEnd = "-",
    this.sundayStart = "-",
    this.sundayEnd = "-",
  });

  Availability copyWith({
    String? uid,
    String? mondayStart,
    String? mondayEnd,
    String? tuesdayStart,
    String? tuesdayEnd,
    String? wednesdayStart,
    String? wednesdayEnd,
    String? thursdayStart,
    String? thursdayEnd,
    String? fridayStart,
    String? fridayEnd,
    String? saturdayStart,
    String? saturdayEnd,
    String? sundayStart,
    String? sundayEnd,
  }) {
    return Availability(
      uid: uid ?? this.uid,
      mondayStart: mondayStart ?? this.mondayStart,
      mondayEnd: mondayEnd ?? this.mondayEnd,
      tuesdayStart: tuesdayStart ?? this.tuesdayStart,
      tuesdayEnd: tuesdayEnd ?? this.tuesdayEnd,
      wednesdayStart: wednesdayStart ?? this.wednesdayStart,
      wednesdayEnd: wednesdayEnd ?? this.wednesdayEnd,
      thursdayStart: thursdayStart ?? this.thursdayStart,
      thursdayEnd: thursdayEnd ?? this.thursdayEnd,
      fridayStart: fridayStart ?? this.fridayStart,
      fridayEnd: fridayEnd ?? this.fridayEnd,
      saturdayStart: saturdayStart ?? this.saturdayStart,
      saturdayEnd: saturdayEnd ?? this.saturdayEnd,
      sundayStart: sundayStart ?? this.sundayStart,
      sundayEnd: sundayEnd ?? this.sundayEnd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'mondayStart': mondayStart,
      'mondayEnd': mondayEnd,
      'tuesdayStart': tuesdayStart,
      'tuesdayEnd': tuesdayEnd,
      'wednesdayStart': wednesdayStart,
      'wednesdayEnd': wednesdayEnd,
      'thursdayStart': thursdayStart,
      'thursdayEnd': thursdayEnd,
      'fridayStart': fridayStart,
      'fridayEnd': fridayEnd,
      'saturdayStart': saturdayStart,
      'saturdayEnd': saturdayEnd,
      'sundayStart': sundayStart,
      'sundayEnd': sundayEnd,
    };
  }

  factory Availability.fromMap(Map<String, dynamic> map) {
    return Availability(
      uid: map['uid'],
      mondayStart: map['mondayStart'],
      mondayEnd: map['mondayEnd'],
      tuesdayStart: map['tuesdayStart'],
      tuesdayEnd: map['tuesdayEnd'],
      wednesdayStart: map['wednesdayStart'],
      wednesdayEnd: map['wednesdayEnd'],
      thursdayStart: map['thursdayStart'],
      thursdayEnd: map['thursdayEnd'],
      fridayStart: map['fridayStart'],
      fridayEnd: map['fridayEnd'],
      saturdayStart: map['saturdayStart'],
      saturdayEnd: map['saturdayEnd'],
      sundayStart: map['sundayStart'],
      sundayEnd: map['sundayEnd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Availability.fromJson(String source) => Availability.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Availability(uid: $uid, mondayStart: $mondayStart, mondayEnd: $mondayEnd, tuesdayStart: $tuesdayStart, tuesdayEnd: $tuesdayEnd, wednesdayStart: $wednesdayStart, wednesdayEnd: $wednesdayEnd, thursdayStart: $thursdayStart, thursdayEnd: $thursdayEnd, fridayStart: $fridayStart, fridayEnd: $fridayEnd, saturdayStart: $saturdayStart, saturdayEnd: $saturdayEnd, sundayStart: $sundayStart, sundayEnd: $sundayEnd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Availability &&
      other.uid == uid &&
      other.mondayStart == mondayStart &&
      other.mondayEnd == mondayEnd &&
      other.tuesdayStart == tuesdayStart &&
      other.tuesdayEnd == tuesdayEnd &&
      other.wednesdayStart == wednesdayStart &&
      other.wednesdayEnd == wednesdayEnd &&
      other.thursdayStart == thursdayStart &&
      other.thursdayEnd == thursdayEnd &&
      other.fridayStart == fridayStart &&
      other.fridayEnd == fridayEnd &&
      other.saturdayStart == saturdayStart &&
      other.saturdayEnd == saturdayEnd &&
      other.sundayStart == sundayStart &&
      other.sundayEnd == sundayEnd;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      mondayStart.hashCode ^
      mondayEnd.hashCode ^
      tuesdayStart.hashCode ^
      tuesdayEnd.hashCode ^
      wednesdayStart.hashCode ^
      wednesdayEnd.hashCode ^
      thursdayStart.hashCode ^
      thursdayEnd.hashCode ^
      fridayStart.hashCode ^
      fridayEnd.hashCode ^
      saturdayStart.hashCode ^
      saturdayEnd.hashCode ^
      sundayStart.hashCode ^
      sundayEnd.hashCode;
  }
}
