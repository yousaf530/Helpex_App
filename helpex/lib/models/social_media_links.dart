// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SocialMediaLinks {
  String? facebook;
  String? linkedin;
  String? twitter;
  String? instagram;
  String? github;
  SocialMediaLinks({
    this.facebook,
    this.linkedin,
    this.twitter,
    this.instagram,
    this.github,
  });

  SocialMediaLinks copyWith({
    String? facebook,
    String? linkedin,
    String? twitter,
    String? instagram,
    String? github,
  }) {
    return SocialMediaLinks(
      facebook: facebook ?? this.facebook,
      linkedin: linkedin ?? this.linkedin,
      twitter: twitter ?? this.twitter,
      instagram: instagram ?? this.instagram,
      github: github ?? this.github,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'facebook': facebook,
      'linkedin': linkedin,
      'twitter': twitter,
      'instagram': instagram,
      'github': github,
    };
  }

  factory SocialMediaLinks.fromMap(Map<String, dynamic> map) {
    return SocialMediaLinks(
      facebook: map['facebook'] != null ? map['facebook'] as String : null,
      linkedin: map['linkedin'] != null ? map['linkedin'] as String : null,
      twitter: map['twitter'] != null ? map['twitter'] as String : null,
      instagram: map['instagram'] != null ? map['instagram'] as String : null,
      github: map['github'] != null ? map['github'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialMediaLinks.fromJson(String source) =>
      SocialMediaLinks.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SocialMediaLinks(facebook: $facebook, linkedin: $linkedin, twitter: $twitter, instagram: $instagram, github: $github)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SocialMediaLinks &&
        other.facebook == facebook &&
        other.linkedin == linkedin &&
        other.twitter == twitter &&
        other.instagram == instagram &&
        other.github == github;
  }

  @override
  int get hashCode {
    return facebook.hashCode ^
        linkedin.hashCode ^
        twitter.hashCode ^
        instagram.hashCode ^
        github.hashCode;
  }
}
