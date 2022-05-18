// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpex_app/models/availability.dart';
import 'package:helpex_app/models/social_media_links.dart';
import 'package:helpex_app/models/uesr_experiences.dart';

class AdvisorToFirestore {
  String uid = "";
  String description = "";
  UserExperiences userExperience = UserExperiences();
  SocialMediaLinks socialMediaLinks = SocialMediaLinks();
  Availability availability = Availability();
  String rates = "";
  String ratesTime = "";

  FirebaseFirestore db = FirebaseFirestore.instance;

  AdvisorToFirestore({
    required this.uid,
    required this.description,
    required this.userExperience,
    required this.socialMediaLinks,
    required this.availability,
    required this.rates,
    required this.ratesTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'rates': rates,
      'ratesTime': ratesTime,
    };
  }

  Future newAdvisorDataToFirebase() async {
    await db
        .collection("Users")
        .doc(uid)
        .collection("Experience")
        .add(userExperience.toMap());
    await db
        .collection("Users")
        .doc(uid)
        .collection("Social")
        .add(socialMediaLinks.toMap());
    await db
        .collection("Users")
        .doc(uid)
        .collection("Availability")
        .add(availability.toMap());
    print("This is done! ");
  }
}
