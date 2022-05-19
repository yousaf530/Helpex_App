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
    this.uid,
    this.name,
    this.email,
    this.dateOfBirth,
    this.isAdvisee,
    this.isAdvisor,
  });

  void withAllInfo({uid, name, email, dateOfBirth, isAdvisee, isAdvisor}) {
    this.uid = uid;
    this.name = name;
    this.email = email;
    this.dateOfBirth = dateOfBirth;
    this.isAdvisee = isAdvisee;
    this.isAdvisor = isAdvisor;

    FirebaseFirestore.instance.collection("Users").doc(uid).set(toMap());
  }

  factory MyUser.getMyUser() {
    return MyUser();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      isAdvisee: map['isAdvisee'] != null ? map['isAdvisee'] as bool : null,
      isAdvisor: map['isAdvisor'] != null ? map['isAdvisor'] as bool : null,
    );
  }

  factory MyUser.fromDocument(DocumentSnapshot doc) {
    return MyUser(
      uid: doc['uid'],
    );
  }

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  MyUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? dateOfBirth,
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
