// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserReviews {
  double rating = 0;
  String? reviewerName;
  String? reviewerUid;
  String? date;
  String? comment;
  UserReviews({
    required this.rating,
    this.reviewerName,
    this.reviewerUid,
    this.date,
    this.comment,
  });

  UserReviews copyWith({
    double? rating,
    String? reviewerName,
    String? reviewerUid,
    String? date,
    String? comment,
  }) {
    return UserReviews(
      rating: rating ?? this.rating,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerUid: reviewerUid ?? this.reviewerUid,
      date: date ?? this.date,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'reviewerName': reviewerName,
      'reviewerUid': reviewerUid,
      'date': date,
      'comment': comment,
    };
  }

  factory UserReviews.fromMap(Map<String, dynamic> map) {
    return UserReviews(
      rating: map['rating'] as double,
      reviewerName:
          map['reviewerName'] != null ? map['reviewerName'] as String : null,
      reviewerUid:
          map['reviewerUid'] != null ? map['reviewerUid'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReviews.fromJson(String source) =>
      UserReviews.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserReviews(rating: $rating, reviewerName: $reviewerName, reviewerUid: $reviewerUid, date: $date, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserReviews &&
        other.rating == rating &&
        other.reviewerName == reviewerName &&
        other.reviewerUid == reviewerUid &&
        other.date == date &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return rating.hashCode ^
        reviewerName.hashCode ^
        reviewerUid.hashCode ^
        date.hashCode ^
        comment.hashCode;
  }
}
