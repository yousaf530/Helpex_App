// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpex_app/screens/Advisee/view_advisor_profile.dart';
import 'package:helpex_app/services/auth.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../chat/adviseeChat.dart';

class AdviseeDashboard extends StatefulWidget {
  const AdviseeDashboard({Key? key}) : super(key: key);

  @override
  State<AdviseeDashboard> createState() => _AdviseeDashboardState();
}

class _AdviseeDashboardState extends State<AdviseeDashboard> {
  String name = "";

  late final Stream<QuerySnapshot>? advisors;
  static FirebaseFirestore db = FirebaseFirestore.instance;
  bool isData = false;
  @override
  void initState() {
    super.initState();

    storeAdvisors();
  }

  storeAdvisors() async {
    advisors = await readAdvisors();
    setState(() {
      isData = true;
    });
  }

  static Future<Stream<QuerySnapshot<Object?>>?> readAdvisors() async {
    try {
      final result = await db
          .collection("Advisor")
          .orderBy("rating", descending: true)
          .snapshots();

      return result;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                elevation: 10.0,
                shadowColor: Colors.grey[100],
                borderRadius: BorderRadius.circular(40),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 18.0),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 0.0),
                    ),
                    suffixIcon: Icon(
                      Icons.search_outlined,
                      color: Color(0xff2D7567),
                    ),
                    hintText: 'Search',
                    hintStyle:
                        GoogleFonts.mulish(textStyle: TextStyle(fontSize: 20)),
                  ),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            isData == false
                ? Center(child: CircularProgressIndicator())
                : StreamBuilder<QuerySnapshot>(
                    stream: (name != "" && name != null)
                        ? FirebaseFirestore.instance
                            .collection("Advisor")
                            .where("expertiesList", arrayContains: name)
                            .snapshots()
                        : advisors,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                          "Something went wrong",
                          style: const TextStyle(fontSize: 20),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: 200.0,
                          height: 100.0,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.grey,
                                    enabled: true,
                                    child: ListView.builder(
                                      itemBuilder: (_, __) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 48.0,
                                              height: 48.0,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: 40.0,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      itemCount: 6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final data = snapshot.requireData;
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return AppCard(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${data.docs[index]["profilePicUrl"]}"),
                                  backgroundColor: Colors.grey[400],
                                  radius: 62.5,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data.docs[index]["name"],
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                                      "Rs." + data.docs[index]["rates"],
                                      style: GoogleFonts.mulish(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RatingBarIndicator(
                                  rating: double.parse(
                                      data.docs[index]["rating"].toString()),
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 5,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff2D7567),
                                      fixedSize: const Size(220, 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      textStyle: const TextStyle(fontSize: 20)),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => AdviseeChatHome(
                                          otherUserID: data.docs[index]["uid"],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Chat',
                                      style: GoogleFonts.mulish(
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      fixedSize: const Size(220, 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      side: BorderSide(
                                        width: 2.0,
                                        color: Color(0xff2D7567),
                                      ),
                                      textStyle: const TextStyle(fontSize: 20)),
                                  onPressed: () {
                                    if (data.docs[index]["uid"] != null) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewAdvisorProfile(
                                            advisorUid: data.docs[index]
                                                ["uid"]!,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'View Profile',
                                    style: GoogleFonts.mulish(
                                      textStyle: TextStyle(
                                          color: Color(0xff2D7567),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
