import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/cards.dart';

class AdvisorCalender extends StatefulWidget {
  const AdvisorCalender({Key? key}) : super(key: key);

  @override
  State<AdvisorCalender> createState() => _AdvisorCalenderState();
}

class _AdvisorCalenderState extends State<AdvisorCalender> {
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
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Advisee Name",
                          hintStyle: GoogleFonts.mulish(
                            textStyle: TextStyle(color: Colors.black54),
                          ),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DateTimeFormField(
                        decoration: InputDecoration(
                          hintText: "Meeting Date",
                          hintStyle: GoogleFonts.mulish(
                            textStyle: TextStyle(color: Colors.black54),
                          ),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.white, width: 0.0),
                          ),
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DateTimeFormField(
                        decoration: InputDecoration(
                          hintText: "Meeting Time",
                          hintStyle: GoogleFonts.mulish(
                            textStyle: TextStyle(color: Colors.black54),
                          ),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.white, width: 0.0),
                          ),
                        ),
                        mode: DateTimeFieldPickerMode.time,
                        autovalidateMode: AutovalidateMode.always,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Total Time for Meeting",
                          hintStyle: GoogleFonts.mulish(
                            textStyle: TextStyle(color: Colors.black54),
                          ),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff2D7567),
                            //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            fixedSize: const Size(220, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                        },
                        child: Text('Create Appointment', style: GoogleFonts.mulish()),
                      ),
                    ]),
              ),
              Text(
                "Appointments",
                style: GoogleFonts.mulish(
                  textStyle: const TextStyle(
                      color: Color(0xff2D7567),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AppCard(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Advisee Name',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.mulish(
                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Meeting Date', textAlign: TextAlign.left, style: GoogleFonts.mulish(
                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Meeting Time', textAlign: TextAlign.left, style: GoogleFonts.mulish(
                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Duration', textAlign: TextAlign.left, style: GoogleFonts.mulish(
                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Status', textAlign: TextAlign.left, style: GoogleFonts.mulish(
                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                              )),
                            ],
                          ),
                      ),
                      SizedBox(
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Advisee Name', textAlign: TextAlign.left, style: GoogleFonts.mulish(
                              textStyle: TextStyle(fontSize: 14),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Meeting Date', textAlign: TextAlign.left, style: GoogleFonts.mulish(
                              textStyle: TextStyle(fontSize: 14),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Meeting Time', textAlign: TextAlign.left, style: GoogleFonts.mulish(
                              textStyle: TextStyle(fontSize: 14),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Duration', textAlign: TextAlign.left, style: GoogleFonts.mulish(
                              textStyle: TextStyle(fontSize: 14),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Status', textAlign: TextAlign.left, style: GoogleFonts.mulish(
                              textStyle: TextStyle(fontSize: 14),
                            )),
                          ],
                        ),
                      ),

                    ],
                  ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
