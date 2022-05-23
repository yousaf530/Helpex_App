// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpex_app/models/user.dart';

import '../../widgets/cards.dart';

class AdvisorCalender extends StatefulWidget {
  const AdvisorCalender({Key? key}) : super(key: key);

  @override
  State<AdvisorCalender> createState() => _AdvisorCalenderState();
}

class _AdvisorCalenderState extends State<AdvisorCalender> {
  late final Stream<QuerySnapshot>? allappointments;
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
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Appointments")
                    .where("advisorUid", isEqualTo: currentUser.uid)
                    .orderBy("date")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      "Something went wrong",
                      style: const TextStyle(fontSize: 20),
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
                              "No Appointments Yet",
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
                        String paidMsg;
                        if (data.docs[index]["isPaid"]) {
                          paidMsg = "Done";
                        } else {
                          paidMsg = "Pending";
                        }
                        return AllAppointmentsCard(
                          name: "${data.docs[index]["adviseeName"]}",
                          meeturl: "${data.docs[index]["meetingLink"]}",
                          meetDate: "${data.docs[index]["date"]}",
                          meetTime: "${data.docs[index]["meetingTimeInMins"]}",
                          meetSlot: "${data.docs[index]["meetingSlot"]}",
                          paidMsg: paidMsg,
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

class AllAppointmentsCard extends StatelessWidget {
  const AllAppointmentsCard({
    Key? key,
    required this.name,
    required this.meeturl,
    required this.meetDate,
    required this.meetTime,
    required this.meetSlot,
    required this.paidMsg,
  }) : super(key: key);

  final String name;
  final String meeturl;
  final String meetDate;
  final String meetTime;
  final String meetSlot;
  final String paidMsg;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Advisee Name',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('Meeting Date',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('Meeting Time',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('Duration',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Link',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mulish(
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Paymment',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mulish(
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                      textStyle: TextStyle(fontSize: 14),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(meetDate,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                      textStyle: TextStyle(fontSize: 14),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(meetSlot,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                      textStyle: TextStyle(fontSize: 14),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(meetTime + " minutes",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.mulish(
                      textStyle: TextStyle(fontSize: 14),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  meeturl,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mulish(
                    color: Colors.blue,
                    textStyle: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  paidMsg,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mulish(
                    textStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
