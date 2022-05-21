// ignore_for_file: prefer_const_constructors, unused_import, must_call_super

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/user.dart';
import '../chat/advisorChatHome.dart';

class AdvisorChatScreen extends StatefulWidget {
  const AdvisorChatScreen({Key? key}) : super(key: key);

  @override
  State<AdvisorChatScreen> createState() => _AdvisorChatScreenState();
}

class _AdvisorChatScreenState extends State<AdvisorChatScreen> {
  final MyUser currentUser = MyUser.getMyUser();
  String currid = "";

  late final Stream<QuerySnapshot>? chats;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    currid = currentUser.uid!;
    chats = readChats(currid);
  }

  static Stream<QuerySnapshot>? readChats(String id) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      final result = db
          .collection("Users")
          .where("isAdvisee", isEqualTo: true)
          .snapshots();

      return result;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("Chats"), backgroundColor: Color(0xff2D7567)),
        body: StreamBuilder<QuerySnapshot>(
            stream: chats,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                  padding: const EdgeInsets.only(bottom: 10.0),
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
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.0),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
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
                    ));
              }
              final data = snapshot.requireData;
              return ListView.builder(
                  itemCount: data.size,
                  // Text(data.docs[index]['name'])
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 4.0),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(0xff2D7567),
                                radius: 25.0,
                                child: Text(data.docs[index]["name"][0],
                                    style: TextStyle(fontSize: 30.0)),
                              ),
                              title: Text(
                                data.docs[index]['name'],
                                style: TextStyle(fontSize: 24),
                              ),
                              // subtitle: Text(
                              //   data.docs[index]['email'],
                              //   style: TextStyle(fontSize: 30),
                              // ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdvisorChatHome(
                                        otherUserID: data.docs[index]["uid"],
                                      ),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}
