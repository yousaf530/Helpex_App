import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
