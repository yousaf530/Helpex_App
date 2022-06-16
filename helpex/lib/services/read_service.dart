import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpex_app/models/advisor.dart';
import 'package:helpex_app/models/availability.dart';
import 'package:helpex_app/models/social_media_links.dart';
import 'package:helpex_app/models/user_experiences.dart';

class ReadService {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future readAdvisee() async {
    return;
  }

  static Future readAdvisor(String uid) async {
    try {
      final result = await db.collection("Advisor").doc(uid).get();
      var data = result.data();
      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Future<Advisor> returnAdvisor(String uid) async {
    final avdData = await readAdvisor(uid);
    Advisor adv = Advisor.fromMap(avdData);
    return adv;
  }

  static Future readAvailability(String uid) async {
    try {
      var data;
      final result = db.collection("Availability").where("uid", isEqualTo: uid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Future<Availability> returnAvailability(String uid) async {
    final data = await readAvailability(uid);
    return Availability.fromMap(data);
  }

  static Future readSocials(String uid) async {
    try {
      var data;
      final result = db.collection("Social").where("uid", isEqualTo: uid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  static Future<SocialMediaLinks> returnSocials(String uid) async {
    final data = await readSocials(uid);
    return SocialMediaLinks.fromMap(data);
  }

  static Future readExperience(String uid) async {
    try {
      var data;
      final result = db.collection("Experience").where("uid", isEqualTo: uid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Future<UserExperiences> returnExperience(String uid) async {
    final data = await readExperience(uid);
    return UserExperiences.fromMap(data);
  }
}
