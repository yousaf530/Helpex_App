// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/widgets/appointments_cards.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AdvisorDashboard extends StatefulWidget {
  const AdvisorDashboard({Key? key}) : super(key: key);

  @override
  State<AdvisorDashboard> createState() => _AdvisorDashboardState();
}

class _AdvisorDashboardState extends State<AdvisorDashboard> {
  late final Stream<QuerySnapshot>? appointments;
  bool isData = false;
  int totalAppointments = 0;
  double totalEarnings = 0;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getData();
  }

  readAppointments() async {
    try {
      var data;
      final result = db
          .collection("Appointments")
          .where("advisorUid", isEqualTo: currentUser.uid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        totalAppointments++;
        data = snapshot.data();
        totalEarnings += data!["cost"];
      }
    } on FirebaseException catch (e) {
      return null;
    }
  }

  readAdvisor() async {
    try {
      final result = await db.collection("Advisor").doc(currentUser.uid).get();
      var data = result.data();
      totalEarnings = data!["totalEarnings"];
      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future<void> getData() async {
    totalEarnings = 0;
    totalAppointments = 0;
    await readAppointments();
    //await readAdvisor();
    setState(() {
      isData = true;
    });
  }

  final MyUser currentUser = MyUser.getMyUser();
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 190,
                              child: Column(
                                children: [
                                  AppCard(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Total\nAppointments',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mulish(
                                              textStyle: const TextStyle(
                                                  color: Color(0xff2D7567),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.black,
                                          ),
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: Color(0xff2D7567),
                                            size: 50,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "$totalAppointments",
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 190,
                              child: Column(
                                children: [
                                  AppCard(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Total\nEarnings',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mulish(
                                              textStyle: const TextStyle(
                                                  color: Color(0xff2D7567),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.black,
                                          ),
                                          Icon(
                                            Icons.attach_money,
                                            color: Color(0xff2D7567),
                                            size: 50,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "$totalEarnings",
                                              style: GoogleFonts.mulish(
                                                textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Todays Bookings',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                      color: Color(0xff2D7567),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Appointments")
                                    .where("advisorUid",
                                        isEqualTo: currentUser.uid)
                                    .where("date",
                                        isEqualTo: DateFormat("dd-MM-yyy")
                                            .format(DateTime.now()))
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
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          child: Text("No Appointments today")),
                                    );
                                  }

                                  final data = snapshot.requireData;

                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: data.size,
                                      itemBuilder: (context, index) {
                                        return AppointmentCard(
                                            name:
                                                "${data.docs[index]["adviseeName"]}",
                                            meeturl:
                                                "${data.docs[index]["meetingLink"]}",
                                            meetDate:
                                                "${data.docs[index]["date"]}",
                                            meetTime:
                                                "${data.docs[index]["meetingTimeInMins"]}",
                                            meetSlot:
                                                "${data.docs[index]["meetingSlot"]}");
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppCard(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Upcoming Appointments',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(
                                        color: Color(0xff2D7567),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Appointments")
                                      .where("advisorUid",
                                          isEqualTo: currentUser.uid)
                                      .where("date",
                                          isGreaterThan: DateFormat("dd-MM-yyy")
                                              .format(DateTime.now()))
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
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            child: Text(
                                                "No Upcoming Appointments")),
                                      );
                                    }
                                    final data = snapshot.requireData;

                                    return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: data.size,
                                        itemBuilder: (context, index) {
                                          return AppointmentCard(
                                              name:
                                                  "${data.docs[index]["adviseeName"]}",
                                              meeturl:
                                                  "${data.docs[index]["meetingLink"]}",
                                              meetDate:
                                                  "${data.docs[index]["date"]}",
                                              meetTime:
                                                  "${data.docs[index]["meetingTimeInMins"]}",
                                              meetSlot:
                                                  "${data.docs[index]["meetingSlot"]}");
                                        });
                                  },
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppCard(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Calendar',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(
                                        color: Color(0xff2D7567),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                TableCalendar(
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  focusedDay: DateTime.now(),
                                  calendarBuilders: CalendarBuilders(
                                    selectedBuilder: (context, date, events) =>
                                        Container(
                                            margin: const EdgeInsets.all(4.0),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Text(
                                              date.day.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                    todayBuilder: (context, date, events) =>
                                        Container(
                                            margin: const EdgeInsets.all(4.0),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Color(0xff2D7567),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Text(
                                              date.day.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                  ),
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 10,
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
