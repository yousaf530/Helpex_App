import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpex_app/models/advisor.dart';
//import 'package:helpex_app/models/capitalize_string.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvisorProfile extends StatefulWidget {
  const AdvisorProfile({Key? key}) : super(key: key);

  @override
  State<AdvisorProfile> createState() => _AdvisorProfileState();
}

class _AdvisorProfileState extends State<AdvisorProfile> {
  bool isData = false;
  late final profile;
  late final experience;
  late final socials;
  MyUser currentUser = MyUser.getMyUser();
  final Advisor advisor = Advisor.getAdvisor();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    getData();
  }

  readProfile() async {
    try {
      final result = await db.collection("Advisor").doc(currentUser.uid).get();
      print(currentUser.uid);
      var data = result.data();

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  readExperience() async {
    try {
      var data;
      final result =
          db.collection("Experience").where("uid", isEqualTo: currentUser.uid);
      print(currentUser.uid);
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
          db.collection("Social").where("uid", isEqualTo: currentUser.uid);
      print(currentUser.uid);
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
    setState(() {
      isData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        //"${currentUser.name!.capitalize()}",
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
                            primary: Colors.grey,
                            //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            fixedSize: const Size(229, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit_pro');
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
                                profile["expertise"],
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
                                "Socials",
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
                                            '3:30',
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
