// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//import 'package:flutter/foundation.dart';

//import 'package:helpex_app/models/social_media_links.dart';

class Advisor {
  String? name = "";
  String? rates = "";
  double? rating = 0.0;
  String? description = "";
  String? ratesTime = "";
  String? uid = "";
  double totalEarnings;
  double totalReviews;
  String profilePicUrl = "";
  String? expertise;

  Advisor({
    this.name,
    this.rates,
    this.rating,
    this.description,
    this.ratesTime,
    this.uid,
    this.totalEarnings = 0,
    this.totalReviews = 0,
    this.profilePicUrl = "",
    this.expertise,
  });

  static Advisor advisor = Advisor();

  factory Advisor.getAdvisor() {
    return advisor;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'rates': rates,
      'rating': rating,
      'description': description,
      'ratesTime': ratesTime,
      'uid': uid,
      'totalEarnings': totalEarnings,
      'totalReviews': totalReviews,
      'profilePicUrl': profilePicUrl,
      'expertise': expertise,
    };
  }

  factory Advisor.fromMap(Map<String, dynamic> map) {
    return Advisor(
      name: map['name'] != null ? map['name'] as String : null,
      rates: map['rates'] != null ? map['rates'] as String : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      description: map['description'] != null ? map['description'] as String : null,
      ratesTime: map['ratesTime'] != null ? map['ratesTime'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      totalEarnings: map['totalEarnings'] as double,
      totalReviews: map['totalReviews'] != null ? map['totalReviews'] as double : 0,
      profilePicUrl: map['profilePicUrl'] as String,
      expertise: map['expertise'] != null ? map['expertise'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Advisor.fromJson(String source) =>
      Advisor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Advisor(name: $name, rates: $rates, rating: $rating, description: $description, ratesTime: $ratesTime, uid: $uid, totalEarnings: $totalEarnings, totalReviews: $totalReviews, profilePicUrl: $profilePicUrl, expertise: $expertise)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Advisor &&
      other.name == name &&
      other.rates == rates &&
      other.rating == rating &&
      other.description == description &&
      other.ratesTime == ratesTime &&
      other.uid == uid &&
      other.totalEarnings == totalEarnings &&
      other.totalReviews == totalReviews &&
      other.profilePicUrl == profilePicUrl &&
      other.expertise == expertise;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      rates.hashCode ^
      rating.hashCode ^
      description.hashCode ^
      ratesTime.hashCode ^
      uid.hashCode ^
      totalEarnings.hashCode ^
      totalReviews.hashCode ^
      profilePicUrl.hashCode ^
      expertise.hashCode;
  }

  Advisor copyWith({
    String? name,
    String? rates,
    double? rating,
    String? description,
    String? ratesTime,
    String? uid,
    double? totalEarnings,
    double? totalReviews,
    String? profilePicUrl,
    String? expertise,
  }) {
    return Advisor(
      name: name ?? this.name,
      rates: rates ?? this.rates,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      ratesTime: ratesTime ?? this.ratesTime,
      uid: uid ?? this.uid,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      totalReviews: totalReviews ?? this.totalReviews,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      expertise: expertise ?? this.expertise,
    );
  }
}
