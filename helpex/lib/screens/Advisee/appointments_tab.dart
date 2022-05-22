// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpex_app/models/user.dart';

import '../../widgets/cards.dart';

class AdviseeAppointments extends StatefulWidget {
  const AdviseeAppointments({Key? key}) : super(key: key);

  @override
  State<AdviseeAppointments> createState() => _AdviseeAppointmentsState();
}

class _AdviseeAppointmentsState extends State<AdviseeAppointments> {
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
                    .where("adviseeUid", isEqualTo: currentUser.uid)
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
                        return AllAppointmentsCard(
                          name: "${data.docs[index]["advisorName"]}",
                          meeturl: "${data.docs[index]["meetingLink"]}",
                          meetDate: "${data.docs[index]["date"]}",
                          meetTime: "${data.docs[index]["meetingTimeInMins"]}",
                          meetSlot: "${data.docs[index]["meetingSlot"]}",
                          isPaid: data.docs[index]["isPaid"],
                          advisorUid: "${data.docs[index]["advisorUid"]}",
                          docId: data.docs[index].id,
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

class AllAppointmentsCard extends StatefulWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;

  updateAppointments() async {
    isPaid = true;
    await db.collection("Appointments").doc(docId).update({"isPaid": isPaid});
  }

  AllAppointmentsCard(
      {Key? key,
      required this.name,
      required this.meeturl,
      required this.meetDate,
      required this.meetTime,
      required this.meetSlot,
      required this.advisorUid,
      required this.docId,
      required this.isPaid})
      : super(key: key);

  final String name;
  final String meeturl;
  final String meetDate;
  final String meetTime;
  final String meetSlot;
  bool isPaid;
  final String advisorUid;
  final String docId;
  @override
  State<AllAppointmentsCard> createState() => _AllAppointmentsCardState();
}

class _AllAppointmentsCardState extends State<AllAppointmentsCard> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Advisor Name',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Meeting Date',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Meeting Time',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Duration',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Link',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mulish(
                        textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
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
                    Text(widget.name,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(fontSize: 14),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.meetDate,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(fontSize: 14),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.meetSlot,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(fontSize: 14),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.meetTime + " minutes",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(fontSize: 14),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.meeturl,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mulish(
                        color: Colors.blue,
                        textStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: !widget.isPaid,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff2D7567),
                  fixedSize: const Size(140, 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  textStyle: const TextStyle(fontSize: 12)),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Select Payment Method',
                            style: GoogleFonts.mulish(
                                color: Color(0xff2D7567),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                fixedSize: const Size(310, 56),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {},
                            child: Text(
                              'Credit/Debit Card',
                              style: GoogleFonts.mulish(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                fixedSize: const Size(300, 46),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {},
                            child: Text(
                              'Easypaisa',
                              style: GoogleFonts.mulish(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                fixedSize: const Size(300, 46),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {},
                            child: Text(
                              'Jazzcash',
                              style: GoogleFonts.mulish(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff2D7567),
                                fixedSize: const Size(300, 56),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {
                              widget.updateAppointments();
                                  Navigator.pop(context, false);
                            },
                            child: Text(
                              'Pay',
                              style: GoogleFonts.mulish(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text('Pay Now',
                  style: GoogleFonts.mulish(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
