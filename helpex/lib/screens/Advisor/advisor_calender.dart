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
