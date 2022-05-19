// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:helpex_app/models/social_media_links.dart';

class Advisor {
  String? cost = "";
  double? ratings = 0.0;
  String? description = "";
  Map<String, String>? timeAvailable;
  SocialMediaLinks? socials;
  List<String>? experties;
  String? ratesTime = "";
  String? uid = "";

  Advisor({
    this.cost,
    this.ratings,
    this.description,
    this.timeAvailable,
    this.socials,
    this.experties,
    this.ratesTime,
    this.uid,
  });

  static Advisor advisor = Advisor();

  factory Advisor.getAdvisor() {
    return advisor;
  }

  Advisor copyWith({
    String? cost,
    double? ratings,
    String? description,
    Map<String, String>? timeAvailable,
    SocialMediaLinks? socials,
    List<String>? experties,
    String? ratesTime,
    String? uid,
  }) {
    return Advisor(
      cost: cost ?? this.cost,
      ratings: ratings ?? this.ratings,
      description: description ?? this.description,
      timeAvailable: timeAvailable ?? this.timeAvailable,
      socials: socials ?? this.socials,
      experties: experties ?? this.experties,
      ratesTime: ratesTime ?? this.ratesTime,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cost': cost,
      'ratings': ratings,
      'description': description,
      'timeAvailable': timeAvailable,
      'socials': socials?.toMap(),
      'experties': experties,
      'ratesTime': ratesTime,
      'uid': uid,
    };
  }

  factory Advisor.fromMap(Map<String, dynamic> map) {
    return Advisor(
      cost: map['cost'],
      ratings: map['ratings']?.toDouble(),
      description: map['description'],
      timeAvailable: Map<String, String>.from(map['timeAvailable']),
      socials: map['socials'] != null ? SocialMediaLinks.fromMap(map['socials']) : null,
      experties: List<String>.from(map['experties']),
      ratesTime: map['ratesTime'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Advisor.fromJson(String source) =>
      Advisor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Advisor(cost: $cost, ratings: $ratings, description: $description, timeAvailable: $timeAvailable, socials: $socials, experties: $experties, ratesTime: $ratesTime, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final collectionEquals = const DeepCollectionEquality().equals;

    return other is Advisor &&
        other.cost == cost &&
        other.ratings == ratings &&
        other.description == description &&
        collectionEquals(other.timeAvailable, timeAvailable) &&
        other.socials == socials &&
        collectionEquals(other.experties, experties) &&
        other.ratesTime == ratesTime &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return cost.hashCode ^
        ratings.hashCode ^
        description.hashCode ^
        timeAvailable.hashCode ^
        socials.hashCode ^
        experties.hashCode ^
        ratesTime.hashCode ^
        uid.hashCode;
  }
}
