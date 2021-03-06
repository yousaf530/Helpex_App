// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:helpex_app/models/advisor.dart';
import 'package:helpex_app/models/availability.dart';
import 'package:helpex_app/models/social_media_links.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/models/user_experiences.dart';
import 'package:helpex_app/screens/Advisor/edit_profile.dart';
import 'package:helpex_app/services/read_service.dart';
import 'package:helpex_app/widgets/cards.dart';

class AdvisorProfile extends StatefulWidget {
  const AdvisorProfile({Key? key}) : super(key: key);

  @override
  State<AdvisorProfile> createState() => _AdvisorProfileState();
}

class _AdvisorProfileState extends State<AdvisorProfile> {
  bool isData = false;
  late Advisor advisor;
  late UserExperiences experience;
  late SocialMediaLinks socials;
  late Availability availability;
  MyUser currentUser = MyUser.getMyUser();
  // final Advisor advisor = Advisor.getAdvisor();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    advisor = await ReadService.returnAdvisor(currentUser.uid!);
    experience = await ReadService.returnExperience(currentUser.uid!);
    socials = await ReadService.returnSocials(currentUser.uid!);
    availability = await ReadService.returnAvailability(currentUser.uid!);
    setState(() {
      isData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getData,
      child: Scaffold(
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
                          backgroundImage: NetworkImage(advisor.profilePicUrl),
                          backgroundColor: Colors.grey[400],
                          radius: 62.5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          advisor.name!,
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
                              advisor.rates!,
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
                              primary: Colors.grey,
                              //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                              fixedSize: const Size(229, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              textStyle: const TextStyle(fontSize: 20)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(),
                                ));
                          },
                          child: Text('Edit', style: GoogleFonts.mulish()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AppCard(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "About Me",
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
                                  advisor.description!,
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
                                  "Expertise",
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
                                  advisor.expertise!,
                                  //"${advisor.experties}",
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
                                            experience.jobTitle!,
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
                                            experience.companyName!,
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
                                            experience.startDate!,
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
                                            experience.endDate,
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
                                        socials.facebook!,
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
                                        socials.linkedin!,
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
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Tuesday:',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Wednesday:',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Thursday:',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Friday:',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Saturday',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Sunday:',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
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
                                              availability.mondayStart,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              ' - ',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              availability.mondayEnd,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              availability.tuesdayStart,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              ' - ',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              availability.tuesdayEnd,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              availability.wednesdayStart,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              ' - ',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              availability.wednesdayEnd,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              availability.thursdayStart,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              ' - ',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              availability.thursdayEnd,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              availability.fridayStart,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              ' - ',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              availability.fridayEnd,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              availability.saturdayStart,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              ' - ',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              availability.saturdayEnd,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              availability.sundayStart,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              ' - ',
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              availability.sundayEnd,
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
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
                                  advisor.rates!,
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
                                          isEqualTo: currentUser.uid)
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
      ),
    );
  }
}

class ReviewsCard extends StatelessWidget {
  const ReviewsCard({
    Key? key,
    required this.name,
    required this.rating,
    required this.comment,
    required this.reviewDate,
  }) : super(key: key);

  final String name;
  final double rating;
  final String comment;
  final String reviewDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: const Divider(
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.mulish(
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              reviewDate,
              style: GoogleFonts.mulish(
                textStyle:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: RatingBarIndicator(
            itemSize: 30.0,
            rating: rating,
            itemCount: 5,
            // itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star_rounded,
              color: Colors.amber,
              size: 5,
            ),
          ),
        ),
        Text(
          comment,
          style: GoogleFonts.mulish(
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
