// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Availability {
  String? mondayStart;
  String? mondayEnd;
  String? tuesdayStart;
  String? tuesdayEnd;
  String? wednesdayStart;
  String? wednesdayEnd;
  String? thursdayStart;
  String? thursdayEnd;
  String? fridayStart;
  String? fridayEnd;
  String? saturdayStart;
  String? saturdayEnd;
  String? sundayStart;
  String? sundayEnd;

  
  Availability({
    this.mondayStart,
    this.mondayEnd,
    this.tuesdayStart,
    this.tuesdayEnd,
    this.wednesdayStart,
    this.wednesdayEnd,
    this.thursdayStart,
    this.thursdayEnd,
    this.fridayStart,
    this.fridayEnd,
    this.saturdayStart,
    this.saturdayEnd,
    this.sundayStart,
    this.sundayEnd,
  });

  Availability copyWith({
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
    return <String, dynamic>{
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
      mondayStart: map['mondayStart'] != null ? map['mondayStart'] as String : null,
      mondayEnd: map['mondayEnd'] != null ? map['mondayEnd'] as String : null,
      tuesdayStart: map['tuesdayStart'] != null ? map['tuesdayStart'] as String : null,
      tuesdayEnd: map['tuesdayEnd'] != null ? map['tuesdayEnd'] as String : null,
      wednesdayStart: map['wednesdayStart'] != null ? map['wednesdayStart'] as String : null,
      wednesdayEnd: map['wednesdayEnd'] != null ? map['wednesdayEnd'] as String : null,
      thursdayStart: map['thursdayStart'] != null ? map['thursdayStart'] as String : null,
      thursdayEnd: map['thursdayEnd'] != null ? map['thursdayEnd'] as String : null,
      fridayStart: map['fridayStart'] != null ? map['fridayStart'] as String : null,
      fridayEnd: map['fridayEnd'] != null ? map['fridayEnd'] as String : null,
      saturdayStart: map['saturdayStart'] != null ? map['saturdayStart'] as String : null,
      saturdayEnd: map['saturdayEnd'] != null ? map['saturdayEnd'] as String : null,
      sundayStart: map['sundayStart'] != null ? map['sundayStart'] as String : null,
      sundayEnd: map['sundayEnd'] != null ? map['sundayEnd'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Availability.fromJson(String source) => Availability.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Availability(mondayStart: $mondayStart, mondayEnd: $mondayEnd, tuesdayStart: $tuesdayStart, tuesdayEnd: $tuesdayEnd, wednesdayStart: $wednesdayStart, wednesdayEnd: $wednesdayEnd, thursdayStart: $thursdayStart, thursdayEnd: $thursdayEnd, fridayStart: $fridayStart, fridayEnd: $fridayEnd, saturdayStart: $saturdayStart, saturdayEnd: $saturdayEnd, sundayStart: $sundayStart, sundayEnd: $sundayEnd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Availability &&
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
    return mondayStart.hashCode ^
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
