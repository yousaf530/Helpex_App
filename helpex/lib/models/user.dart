import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String? uid;
  String? name;
  String? email;
  String? dateOfBirth;
  bool? isAdvisee;
  bool? isAdvisor;

  MyUser({this.uid});

  void withAllInfo({uid, name, email, dateOfBirth, isAdvisee, isAdvisor}) {
    this.uid = uid;
    this.name = name;
    this.email = email;
    this.dateOfBirth = dateOfBirth;
    this.isAdvisee = isAdvisee;
    this.isAdvisor = isAdvisor;

    FirebaseFirestore.instance.collection("Users").add(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "dateOfBirth": dateOfBirth,
      "isAdvisee": isAdvisee,
      "isAdvisor": isAdvisor
    };
  }
}
