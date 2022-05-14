import 'package:flutter/material.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvisorProfile extends StatefulWidget {
  const AdvisorProfile({Key? key}) : super(key: key);

  @override
  State<AdvisorProfile> createState() => _AdvisorProfileState();
}

class _AdvisorProfileState extends State<AdvisorProfile> {
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
              CircleAvatar(
                //backgroundImage: (),
                backgroundColor: Colors.grey[400],
                radius: 62.5,
                child: const Text(
                  'poop',
                  style: TextStyle(color: Colors.white),
                ), //Text
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Full Name",
                style: GoogleFonts.mulish(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                    "Rs. 20,000",
                    style: GoogleFonts.mulish(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    fixedSize: const Size(229, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {},
                child: Text('Edit', style: GoogleFonts.mulish()),
              ),
              const SizedBox(
                height: 15,
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About me',
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
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In urna lectus nibh non, pulvinar iaculis scelerisque. Sapien fusce purus aliquet purus blandit in elementum.',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expertise',
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
                      Text(
                        'Hello 2',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Experience',
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
                      Text(
                        'Hello 2',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Social Media',
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
                      Text(
                        'Hello 2',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Availability',
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
                      Text(
                        'Monday:\nTuesday:\nWednesday:\nThursday:\nFriday:\nSaturday:\nSunday:',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Text(
                        'Time Duration:',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rates',
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
                      Text(
                        'Hello 2',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reviews',
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
                      Text(
                        'Hello 2',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
