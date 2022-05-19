// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SocialMediaLinks {
  String? uid = "";
  String? facebook;
  String? linkedin;
  String? twitter;
  String? instagram;
  String? github;
  SocialMediaLinks({
    this.uid,
    this.facebook,
    this.linkedin,
    this.twitter,
    this.instagram,
    this.github,
  });

  SocialMediaLinks copyWith({
    String? uid,
    String? facebook,
    String? linkedin,
    String? twitter,
    String? instagram,
    String? github,
  }) {
    return SocialMediaLinks(
      uid: uid ?? this.uid,
      facebook: facebook ?? this.facebook,
      linkedin: linkedin ?? this.linkedin,
      twitter: twitter ?? this.twitter,
      instagram: instagram ?? this.instagram,
      github: github ?? this.github,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'facebook': facebook,
      'linkedin': linkedin,
      'twitter': twitter,
      'instagram': instagram,
      'github': github,
    };
  }

  factory SocialMediaLinks.fromMap(Map<String, dynamic> map) {
    return SocialMediaLinks(
      uid: map['uid'],
      facebook: map['facebook'],
      linkedin: map['linkedin'],
      twitter: map['twitter'],
      instagram: map['instagram'],
      github: map['github'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialMediaLinks.fromJson(String source) => SocialMediaLinks.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SocialMediaLinks(uid: $uid, facebook: $facebook, linkedin: $linkedin, twitter: $twitter, instagram: $instagram, github: $github)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SocialMediaLinks &&
      other.uid == uid &&
      other.facebook == facebook &&
      other.linkedin == linkedin &&
      other.twitter == twitter &&
      other.instagram == instagram &&
      other.github == github;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      facebook.hashCode ^
      linkedin.hashCode ^
      twitter.hashCode ^
      instagram.hashCode ^
      github.hashCode;
  }
}
