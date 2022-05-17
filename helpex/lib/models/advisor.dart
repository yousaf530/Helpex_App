// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:helpex_app/models/social_media_links.dart';

class Advisor {
  String cost = "";
  double ratings = 0.0;
  Map<String, String>? timeAvailable;
  SocialMediaLinks? socials;
  List<String>? experties;

  Advisor({
    required this.cost,
    required this.ratings,
    this.timeAvailable,
    this.socials,
    this.experties,
  });

  Advisor copyWith({
    String? cost,
    double? ratings,
    Map<String, String>? timeAvailable,
    SocialMediaLinks? socials,
    List<String>? experties,
  }) {
    return Advisor(
      cost: cost ?? this.cost,
      ratings: ratings ?? this.ratings,
      timeAvailable: timeAvailable ?? this.timeAvailable,
      socials: socials ?? this.socials,
      experties: experties ?? this.experties,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cost': cost,
      'ratings': ratings,
      'timeAvailable': timeAvailable,
      'socials': socials?.toMap(),
      'experties': experties,
    };
  }

  factory Advisor.fromMap(Map<String, dynamic> map) {
    return Advisor(
      cost: map['cost'] as String,
      ratings: map['ratings'] as double,
      timeAvailable: map['timeAvailable'] != null
          ? Map<String, String>.from(
              (map['timeAvailable'] as Map<String, String>))
          : null,
      socials: map['socials'] != null
          ? SocialMediaLinks.fromMap(map['socials'] as Map<String, dynamic>)
          : null,
      experties: map['experties'] != null
          ? List<String>.from((map['experties'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Advisor.fromJson(String source) =>
      Advisor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Advisor(cost: $cost, ratings: $ratings, timeAvailable: $timeAvailable, socials: $socials, experties: $experties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Advisor &&
        other.cost == cost &&
        other.ratings == ratings &&
        mapEquals(other.timeAvailable, timeAvailable) &&
        other.socials == socials &&
        listEquals(other.experties, experties);
  }

  @override
  int get hashCode {
    return cost.hashCode ^
        ratings.hashCode ^
        timeAvailable.hashCode ^
        socials.hashCode ^
        experties.hashCode;
  }
}
