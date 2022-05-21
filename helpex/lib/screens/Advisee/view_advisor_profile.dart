import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpex_app/models/advisor.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/screens/chat/adviseeChat.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAdvisorProfile extends StatefulWidget {
  final String advisorUid;
  const ViewAdvisorProfile({required this.advisorUid, Key? key})
      : super(key: key);

  @override
  State<ViewAdvisorProfile> createState() => _ViewAdvisorProfileState();
}

class _ViewAdvisorProfileState extends State<ViewAdvisorProfile> {
  bool isData = false;
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
      print(widget.advisorUid);
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
      print(widget.advisorUid);
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
      print(widget.advisorUid);
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
      print(widget.advisorUid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
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
                        //backgroundImage: (),
                        backgroundColor: Colors.grey[400],
                        radius: 62.5,
                        child: const Text(
                          'poop',
                          style: TextStyle(color: Colors.white),
                        ), //Text
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

                                         Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                     AdviseeChatHome(otherUserID:profile["uid"] ,)));


                                    },
                        child: Text('Start a Chat',
                            style: GoogleFonts.mulish(
                              textStyle: TextStyle(
                                  color: Color(0xff2D7567),
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
                                      Text(
                                        "Job Title",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "Company Name",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "Start Date",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "End Date",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  //add values here
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        experience["jobTitle"],
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        experience["companyName"],
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        experience["startDate"],
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        experience["endDate"],
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
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
                              Row(
                                children: [
                                  const Icon(
                                    Icons.facebook_outlined,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    socials["facebook"],
                                    //'${advisor.socials}',
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.facebook_outlined,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    socials["linkedin"],
                                    //'${advisor.socials}',
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
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
                              const Divider(
                                color: Colors.black,
                              ),
                              Text(
                                'Hello 2',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
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
