// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpex_app/models/availability.dart';
import 'package:helpex_app/models/social_media_links.dart';
import 'package:helpex_app/models/user_experiences.dart';
import 'package:helpex_app/models/user.dart';

class AdvisorToFirestore {
  MyUser currentUser = MyUser.getMyUser();
  String uid = "";
  String description = "";
  UserExperiences userExperience = UserExperiences(onGoing: false);
  SocialMediaLinks socialMediaLinks = SocialMediaLinks();
  Availability? availability = Availability();
  String rates = "";
  String ratesTime = "";
  String expertise = "";
  double totalEarnings;
  String profilePicUrl = "";
  double totalReviews;
  double rating;

  FirebaseFirestore db = FirebaseFirestore.instance;

  AdvisorToFirestore(
      {required this.uid,
      required this.description,
      required this.userExperience,
      required this.socialMediaLinks,
      required this.availability,
      required this.rates,
      required this.ratesTime,
      required this.expertise,
      this.totalReviews = 0,
      this.rating = 0,
      this.profilePicUrl =
          "https://firebasestorage.googleapis.com/v0/b/helpexfyp.appspot.com/o/Avatar.jpg?alt=media&token=7e102140-9a95-4702-b917-9b7317ed9d31",
      this.totalEarnings = 0});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'rates': rates,
      'ratesTime': ratesTime,
      'uid': currentUser.uid,
      'name': currentUser.name,
      'email': currentUser.email,
      'expertise': expertise,
      'totalEarnings': totalEarnings,
      'profilePicUrl': profilePicUrl,
      'rating': rating,
      'totalReviews': totalReviews,
    };
  }

  Future newAdvisorDataToFirebase() async {
    await db.collection("Advisor").doc(currentUser.uid).set(toMap());
    userExperience.uid = currentUser.uid;
    await db.collection("Experience").add(userExperience.toMap());
    socialMediaLinks.uid = currentUser.uid;
    await db.collection("Social").add(socialMediaLinks.toMap());
    availability?.uid = currentUser.uid!;
    await db.collection("Availability").add(availability!.toMap());
  }
}
