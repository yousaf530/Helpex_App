// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserExperiences {
  String? uid = "";
  String? companyName = "";
  String? jobTitle = "";
  String? startDate = "";
  String? endDate = "";
  bool? onGoing = false;
  UserExperiences({
    this.uid,
    this.companyName,
    this.jobTitle,
    this.startDate,
    this.endDate,
    this.onGoing,
  });

  UserExperiences copyWith({
    String? uid,
    String? companyName,
    String? jobTitle,
    String? startDate,
    String? endDate,
    bool? onGoing,
  }) {
    return UserExperiences(
      uid: uid ?? this.uid,
      companyName: companyName ?? this.companyName,
      jobTitle: jobTitle ?? this.jobTitle,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      onGoing: onGoing ?? this.onGoing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'companyName': companyName,
      'jobTitle': jobTitle,
      'startDate': startDate,
      'endDate': endDate,
      'onGoing': onGoing,
    };
  }

  factory UserExperiences.fromMap(Map<String, dynamic> map) {
    return UserExperiences(
      uid: map['uid'],
      companyName: map['companyName'],
      jobTitle: map['jobTitle'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      onGoing: map['onGoing'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserExperiences.fromJson(String source) => UserExperiences.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserExperiences(uid: $uid, companyName: $companyName, jobTitle: $jobTitle, startDate: $startDate, endDate: $endDate, onGoing: $onGoing)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserExperiences &&
      other.uid == uid &&
      other.companyName == companyName &&
      other.jobTitle == jobTitle &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.onGoing == onGoing;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      companyName.hashCode ^
      jobTitle.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      onGoing.hashCode;
  }
}
