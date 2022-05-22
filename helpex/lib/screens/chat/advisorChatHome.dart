// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpex_app/models/appointments.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/screens/chat/WriteMessageService.dart';
import 'package:helpex_app/screens/chat/advisorChat.dart';
import 'package:intl/intl.dart';

class AdvisorChatHome extends StatefulWidget {
  final String otherUserID;

  const AdvisorChatHome({Key? key, required this.otherUserID})
      : super(key: key);

  @override
  State<AdvisorChatHome> createState() => _AdvisorChatHomeState();
}

class _AdvisorChatHomeState extends State<AdvisorChatHome> {
  final _formKey = GlobalKey<FormState>();
  MyUser currentUser = MyUser.getMyUser();

  FirebaseFirestore db = FirebaseFirestore.instance;

  Apointments createAppointment = Apointments();

  void addAppointment() async {
    final res1 = await db.collection("Users").doc(widget.otherUserID);
    var querySnapshots = await res1.get();

    final res2 = await db.collection("Advisor").doc(currentUser.uid);
    var querySnapshot = await res2.get();

    var data1 = querySnapshots.data();
    var data2 = querySnapshot.data();

    double earnings = data2!["totalEarnings"].toDouble();
    earnings = earnings + createAppointment.cost;

    await db
        .collection("Advisor")
        .doc(currentUser.uid)
        .update({"totalEarnings": earnings});
    createAppointment.adviseeName = data1!["name"];
    await db.collection("Appointments").add(createAppointment.toMap());
    WriteMessageService.sendMessageAdvisor(createAppointment.toString(), 1,
        currentUser.uid!, widget.otherUserID, currentUser.name!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Chatting... "),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              child: TextButton.icon(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: SingleChildScrollView(
                              child: Container(
                                height: 340,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Add a Meeting',
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
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(
                                            //   color: Colors.grey,
                                            // )),
                                            children: [
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                minLines: 1,
                                                decoration: InputDecoration(
                                                  hintText: "Cost",
                                                  hintStyle: GoogleFonts.mulish(
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
                                                  createAppointment.cost =
                                                      double.tryParse(value)!
                                                          .toDouble();
                                                },
                                              ),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                minLines: 1,
                                                decoration: InputDecoration(
                                                  hintText: "Time in Minutes",
                                                  hintStyle: GoogleFonts.mulish(
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
                                                  createAppointment
                                                          .meetingTimeInMins =
                                                      double.tryParse(value)!
                                                          .toDouble();
                                                },
                                              ),
                                              DateTimeFormField(
                                                decoration: InputDecoration(
                                                  hintText: "Meeting Date",
                                                  hintStyle: GoogleFonts.mulish(
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
                                                mode: DateTimeFieldPickerMode
                                                    .date,
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                onDateSelected:
                                                    (DateTime value) {
                                                  createAppointment.date =
                                                      DateFormat("dd-MM-yyy")
                                                          .format(value);
                                                },
                                              ),
                                              DateTimeFormField(
                                                decoration: InputDecoration(
                                                  hintText: "Meeting Starts At",
                                                  hintStyle: GoogleFonts.mulish(
                                                    textStyle: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.white,
                                                            width: 0.0),
                                                  ),
                                                ),
                                                mode: DateTimeFieldPickerMode
                                                    .time,
                                                autovalidateMode:
                                                    AutovalidateMode.always,
                                                onDateSelected:
                                                    (DateTime value) {
                                                  createAppointment
                                                          .meetingSlot =
                                                      DateFormat.jm()
                                                          .format(value);
                                                },
                                              ),
                                              TextFormField(
                                                keyboardType: TextInputType.url,
                                                minLines: 1,
                                                decoration: InputDecoration(
                                                  hintText: "Meeting Link",
                                                  hintStyle: GoogleFonts.mulish(
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
                                                  createAppointment
                                                      .meetingLink = value;
                                                },
                                              ),
                                            ]),
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
                                    textStyle: const TextStyle(fontSize: 20)),
                                onPressed: () {
                                  createAppointment.adviseeUid =
                                      widget.otherUserID;
                                  createAppointment.advisorUid =
                                      currentUser.uid!;
                                  createAppointment.advisorName =
                                      currentUser.name!;
                                  addAppointment();
                                  Navigator.pop(context, false);
                                },
                                child: Text('Add Meeting',
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
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Add Meeting',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
              ),
            )
          ],
          backgroundColor: Color(0xff2D7567)),
      body: AdvisorChat(otherUserID: widget.otherUserID),
    );
  }
}
