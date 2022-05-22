// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/widgets/notification_card.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  MyUser currentUser = MyUser.getMyUser();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Appointments")
                    .where("advisorUid", isEqualTo: currentUser.uid)
                    .where("date",
                        isEqualTo:
                            DateFormat("dd-MM-yyy").format(DateTime.now()))
                    .orderBy(
                      "meetingSlot",
                    )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Something went wrong",
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(child: CircularProgressIndicator());
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No New Notifications",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
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
                        return NotificationCard(
                          name: "${data.docs[index]["adviseeName"]}",
                          meetTime: "${data.docs[index]["meetingSlot"]}",
                        );
                      });
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
