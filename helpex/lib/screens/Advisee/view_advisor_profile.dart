// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helpex_app/models/advisor.dart';
import 'package:helpex_app/models/reviews.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/screens/Advisor/profile.dart';
import 'package:helpex_app/screens/chat/adviseeChat.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ViewAdvisorProfile extends StatefulWidget {
  final String advisorUid;
  const ViewAdvisorProfile({required this.advisorUid, Key? key})
      : super(key: key);

  @override
  State<ViewAdvisorProfile> createState() => _ViewAdvisorProfileState();
}

class _ViewAdvisorProfileState extends State<ViewAdvisorProfile> {
  MyUser currentUser = MyUser.getMyUser();
  bool isData = false;
  String reviewNote = "";
  double reviewRating = 0;
  late final profile;
  late final experience;
  late final socials;
  late final availability;
  final Advisor advisor = Advisor.getAdvisor();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    getData();
  }

  readProfile() async {
    try {
      final result =
          await db.collection("Advisor").doc(widget.advisorUid).get();
      var data = result.data();

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  readExperience() async {
    try {
      var data;
      final result = db
          .collection("Experience")
          .where("uid", isEqualTo: widget.advisorUid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  readSocials() async {
    try {
      var data;
      final result =
          db.collection("Social").where("uid", isEqualTo: widget.advisorUid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  readAvailability() async {
    try {
      var data;
      final result = db
          .collection("Availability")
          .where("uid", isEqualTo: widget.advisorUid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  addReview(String reviewNote, double reviewRating) async {
    UserReviews review = UserReviews(
        reviewerUid: currentUser.uid!,
        advisorUid: widget.advisorUid,
        rating: reviewRating,
        comment: reviewNote,
        reviewerName: currentUser.name!,
        date: DateFormat("dd-MM-yyyy").format(DateTime.now()) +
            "  " +
            DateFormat("hh:mm a").format(DateTime.now()));
    await db.collection("Reviews").add(review.toMap());
  }

  getData() async {
    profile = await readProfile();
    experience = await readExperience();
    socials = await readSocials();
    availability = await readAvailability();
    setState(() {
      isData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isData == false
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage("${profile["profilePicUrl"]}"),
                        backgroundColor: Colors.grey[400],
                        radius: 62.5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        profile["name"],
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.money_outlined,
                            color: Color(0xff2D7567),
                            size: 30.0,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            profile["rates"],
                            style: GoogleFonts.mulish(
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: const Size(220, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdviseeChatHome(
                                    otherUserID: profile["uid"],
                                  )));
                        },
                        child: Text('Start a Chat',
                            style: GoogleFonts.mulish(
                              textStyle: const TextStyle(
                                  color: Color(0xff2D7567),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff2D7567),
                            fixedSize: const Size(220, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Container(
                                        height: 300,
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Leave a review',
                                                style: GoogleFonts.mulish(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff2D7567),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.black,
                                              ),
                                              Container(
                                                height: 220,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                  color: Colors.grey,
                                                )),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  minLines:
                                                      1, //Normal textInputField will be displayed
                                                  maxLines: 7,
                                                  decoration: InputDecoration(
                                                    hintText: "Write a review",
                                                    hintStyle:
                                                        GoogleFonts.mulish(
                                                      textStyle: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    border: InputBorder.none,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 0.0),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    reviewNote = value;
                                                  },
                                                ),
                                              ),
                                              RatingBar.builder(
                                                initialRating: 0,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.amber,
                                                  size: 5,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  reviewRating = rating;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xff2D7567),
                                            fixedSize: const Size(220, 40),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            textStyle:
                                                const TextStyle(fontSize: 20)),
                                        onPressed: () {
                                          addReview(reviewNote, reviewRating);
                                          Navigator.pop(context, false);
                                        },
                                        child: Text('Submit Review',
                                            style: GoogleFonts.mulish(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ),
                                    ],
                                  ));
                        },
                        child: Text('Leave a Review',
                            style: GoogleFonts.mulish(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AppCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About me',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color(0xff2D7567),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Text(
                                profile["description"],
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ]),
                      ),
                      AppCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expertise',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color(0xff2D7567),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Text(
                                profile["expertise"],
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ]),
                      ),
                      AppCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Experience',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color(0xff2D7567),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Job Title",
                                          style: GoogleFonts.mulish(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Company",
                                          style: GoogleFonts.mulish(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Start Date",
                                          style: GoogleFonts.mulish(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "End Date",
                                          style: GoogleFonts.mulish(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  //add values here
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          experience["jobTitle"],
                                          style: GoogleFonts.mulish(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          experience["companyName"],
                                          style: GoogleFonts.mulish(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          experience["startDate"],
                                          style: GoogleFonts.mulish(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          experience["endDate"],
                                          style: GoogleFonts.mulish(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      AppCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Social Media',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color(0xff2D7567),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.link_outlined,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      socials["facebook"],
                                      //'${advisor.socials}',
                                      style: GoogleFonts.mulish(
                                        textStyle:
                                            const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.link_outlined,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      socials["linkedin"],
                                      //'${advisor.socials}',
                                      style: GoogleFonts.mulish(
                                        textStyle:
                                            const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      AppCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Availability',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color(0xff2D7567),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Monday:',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Tuesday:',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Wednesday:',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Thursday:',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Friday:',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Saturday',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Sunday:',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 67,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            availability["mondayStart"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            ' - ',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            availability["mondayEnd"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            availability["tuesdayStart"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            ' - ',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            availability["tuesdayEnd"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            availability["wednesdayStart"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            ' - ',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            availability["wednesdayEnd"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            availability["thursdayStart"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            ' - ',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            availability["thursdayEnd"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            availability["fridayStart"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            ' - ',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            availability["fridayEnd"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            availability["saturdayStart"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            ' - ',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            availability["saturdayEnd"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            availability["sundayStart"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            ' - ',
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            availability["sundayEnd"],
                                            style: GoogleFonts.mulish(
                                              textStyle:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      AppCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rates',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color(0xff2D7567),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Text(
                                profile["rates"],
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ]),
                      ),
                      AppCard(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reviews',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color(0xff2D7567),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Reviews")
                                    .where("advisorUid",
                                        isEqualTo: widget.advisorUid)
                                    .orderBy("date", descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text(
                                      "Something went wrong",
                                      style: const TextStyle(fontSize: 20),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox(
                                        child: CircularProgressIndicator());
                                  }

                                  if (snapshot.data!.docs.isEmpty) {
                                    return Column(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Column(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            const Divider(
                                              color: Colors.black,
                                            ),
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "No Reviews",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }

                                  final data = snapshot.requireData;

                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: data.size,
                                      itemBuilder: (context, index) {
                                        return ReviewsCard(
                                          comment:
                                              "${data.docs[index]["comment"]}",
                                          name:
                                              "${data.docs[index]["reviewerName"]}",
                                          rating: data.docs[index]["rating"],
                                          reviewDate:
                                              "${data.docs[index]["date"]}",
                                        );
                                      });
                                },
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
