// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserReviews {
  double rating = 0;
  String reviewerName;
  String reviewerUid;
  String date;
  String comment;
  String advisorUid;
  UserReviews({
    required this.rating,
    required this.reviewerName,
    required this.reviewerUid,
    required this.date,
    required this.comment,
    required this.advisorUid,
  });

  UserReviews copyWith({
    double? rating,
    String? reviewerName,
    String? reviewerUid,
    String? date,
    String? comment,
    String? advisorUid,
  }) {
    return UserReviews(
      rating: rating ?? this.rating,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerUid: reviewerUid ?? this.reviewerUid,
      date: date ?? this.date,
      comment: comment ?? this.comment,
      advisorUid: advisorUid ?? this.advisorUid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'reviewerName': reviewerName,
      'reviewerUid': reviewerUid,
      'date': date,
      'comment': comment,
      'advisorUid': advisorUid,
    };
  }

  factory UserReviews.fromMap(Map<String, dynamic> map) {
    return UserReviews(
      rating: map['rating'] as double,
      reviewerName: map['reviewerName'] as String,
      reviewerUid: map['reviewerUid'] as String,
      date: map['date'] as String,
      comment: map['comment'] as String,
      advisorUid: map['advisorUid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReviews.fromJson(String source) =>
      UserReviews.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserReviews(rating: $rating, reviewerName: $reviewerName, reviewerUid: $reviewerUid, date: $date, comment: $comment, advisorUid: $advisorUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserReviews &&
      other.rating == rating &&
      other.reviewerName == reviewerName &&
      other.reviewerUid == reviewerUid &&
      other.date == date &&
      other.comment == comment &&
      other.advisorUid == advisorUid;
  }

  @override
  int get hashCode {
    return rating.hashCode ^
      reviewerName.hashCode ^
      reviewerUid.hashCode ^
      date.hashCode ^
      comment.hashCode ^
      advisorUid.hashCode;
  }
}
