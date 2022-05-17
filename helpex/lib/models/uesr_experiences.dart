// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserExperiences {
  String? companyName = "";
  String? jobTitle = "";
  String? startDate = "";
  String? endDate = "";
  bool? onGoing = false;
  UserExperiences({
    this.companyName,
    this.jobTitle,
    this.startDate,
    this.endDate,
    this.onGoing,
  });

  UserExperiences copyWith({
    String? companyName,
    String? jobTitle,
    String? startDate,
    String? endDate,
    bool? onGoing,
  }) {
    return UserExperiences(
      companyName: companyName ?? this.companyName,
      jobTitle: jobTitle ?? this.jobTitle,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      onGoing: onGoing ?? this.onGoing,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyName': companyName,
      'jobTitle': jobTitle,
      'startDate': startDate,
      'endDate': endDate,
      'onGoing': onGoing,
    };
  }

  factory UserExperiences.fromMap(Map<String, dynamic> map) {
    return UserExperiences(
      companyName: map['companyName'] as String,
      jobTitle: map['jobTitle'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      onGoing: map['onGoing'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserExperiences.fromJson(String source) =>
      UserExperiences.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserExperiences(companyName: $companyName, jobTitle: $jobTitle, startDate: $startDate, endDate: $endDate, onGoing: $onGoing)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserExperiences &&
        other.companyName == companyName &&
        other.jobTitle == jobTitle &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.onGoing == onGoing;
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
        jobTitle.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        onGoing.hashCode;
  }
}
