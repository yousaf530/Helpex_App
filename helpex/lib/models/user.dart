// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String? uid;
  String? name;
  String? email;
  String? dateOfBirth;
  bool? isAdvisee;
  bool? isAdvisor;

  MyUser({
    this.uid = "",
    this.name = "",
    this.email = "",
    this.dateOfBirth = "",
    this.isAdvisee = false,
    this.isAdvisor = false,
  });

  static MyUser user = MyUser();

  void withAllInfo({uid, name, email, dateOfBirth, isAdvisee, isAdvisor}) {
    user.uid = uid;
    user.name = name;
    user.email = email;
    user.dateOfBirth = dateOfBirth;
    user.isAdvisee = isAdvisee;
    user.isAdvisor = isAdvisor;

    FirebaseFirestore.instance.collection("Users").doc(uid).set(toMap());
  }

  factory MyUser.getMyUser() {
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'isAdvisee': isAdvisee,
      'isAdvisor': isAdvisor,
    };
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      dateOfBirth: map['dateOfBirth'],
      isAdvisor: map['isAdvisor'],
    );
  }

  factory MyUser.fromDocument(DocumentSnapshot doc) {
    return MyUser(
      uid: doc['uid'],
    );
  }

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source));

  MyUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? dateOfBirth,
    String? totalEarnings,
    bool? isAdvisee,
    bool? isAdvisor,
  }) {
    return MyUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isAdvisee: isAdvisee ?? this.isAdvisee,
      isAdvisor: isAdvisor ?? this.isAdvisor,
    );
  }

  @override
  String toString() {
    return 'MyUser(uid: $uid, name: $name, email: $email, dateOfBirth: $dateOfBirth, isAdvisee: $isAdvisee, isAdvisor: $isAdvisor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyUser &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.dateOfBirth == dateOfBirth &&
        other.isAdvisee == isAdvisee &&
        other.isAdvisor == isAdvisor;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        dateOfBirth.hashCode ^
        isAdvisee.hashCode ^
        isAdvisor.hashCode;
  }
}
