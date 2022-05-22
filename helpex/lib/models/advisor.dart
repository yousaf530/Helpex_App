// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:helpex_app/models/social_media_links.dart';

class Advisor {
  String? name = "";
  String? cost = "";
  double? ratings = 0.0;
  String? description = "";
  Map<String, String>? timeAvailable;
  SocialMediaLinks? socials;
  List<String>? experties;
  String? ratesTime = "";
  String? uid = "";
  double totalEarnings;
  String profilePic = "";
  List<String>? expertiesList;

  Advisor({
    this.name,
    this.cost,
    this.ratings,
    this.description,
    this.timeAvailable,
    this.socials,
    this.experties,
    this.ratesTime,
    this.uid,
    this.totalEarnings = 0,
    this.profilePic = "",
  });

  static Advisor advisor = Advisor();

  factory Advisor.getAdvisor() {
    return advisor;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cost': cost,
      'ratings': ratings,
      'description': description,
      'timeAvailable': timeAvailable,
      'socials': socials?.toMap(),
      'experties': experties,
      'ratesTime': ratesTime,
      'uid': uid,
      'totalEarnings': totalEarnings,
      'profilePic': profilePic,
    };
  }

  factory Advisor.fromMap(Map<String, dynamic> map) {
    return Advisor(
      name: map['name'],
      cost: map['cost'],
      ratings: map['ratings']?.toDouble(),
      description: map['description'],
      timeAvailable: Map<String, String>.from(map['timeAvailable']),
      socials: map['socials'] != null
          ? SocialMediaLinks.fromMap(map['socials'])
          : null,
      experties: List<String>.from(map['experties']),
      ratesTime: map['ratesTime'],
      uid: map['uid'],
      totalEarnings: map['totalEarnings'],
      profilePic: map['profilePic'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Advisor.fromJson(String source) =>
      Advisor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Advisor(name: $name, cost: $cost, ratings: $ratings, description: $description, timeAvailable: $timeAvailable, socials: $socials, experties: $experties, ratesTime: $ratesTime, uid: $uid, totalEarnings: $totalEarnings, profilePic: $profilePic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Advisor &&
        other.name == name &&
        other.cost == cost &&
        other.ratings == ratings &&
        other.description == description &&
        mapEquals(other.timeAvailable, timeAvailable) &&
        other.socials == socials &&
        listEquals(other.experties, experties) &&
        other.ratesTime == ratesTime &&
        other.uid == uid &&
        other.totalEarnings == totalEarnings &&
        other.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        cost.hashCode ^
        ratings.hashCode ^
        description.hashCode ^
        timeAvailable.hashCode ^
        socials.hashCode ^
        experties.hashCode ^
        ratesTime.hashCode ^
        uid.hashCode ^
        totalEarnings.hashCode ^
        profilePic.hashCode;
  }
}
