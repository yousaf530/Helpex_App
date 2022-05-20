import 'package:flutter/material.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAdvisorProfile extends StatefulWidget {
  const ViewAdvisorProfile({Key? key}) : super(key: key);

  @override
  State<ViewAdvisorProfile> createState() => _ViewAdvisorProfileState();
}

class _ViewAdvisorProfileState extends State<ViewAdvisorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
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
                  "Advisor Name",
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
                      primary: Color(0xff2D7567),
                      fixedSize: const Size(220, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {

                  },
                  child: Text('Book an Appointment',
                      style: GoogleFonts.mulish(
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      fixedSize: const Size(220, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/view_advisor_pro');
                  },
                  child: Text('Start a Chat',
                      style: GoogleFonts.mulish(
                        textStyle: TextStyle(
                            color: Color(0xff2D7567), fontSize: 20, fontWeight: FontWeight.w600),
                      )),
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
                        Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Job Title",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "Company Name",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "Start Date",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "End Date",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  //add values here
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Job Title",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Company Name",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Start Date",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "End Date",
                                        style: GoogleFonts.mulish(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
                       Row(
                                children: [
                                  const Icon(
                                    Icons.facebook_outlined,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                "Facebook",
                                //'${advisor.socials}',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                
                              ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.facebook_outlined,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                "Linkedin",
                                //'${advisor.socials}',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                
                              ),
                                ],
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
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Row(
                                  children: [
                                    Text('Monday:',
                                      style: GoogleFonts.mulish(
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Tuesday:',
                                      style: GoogleFonts.mulish(
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Wednesday:',
                                      style: GoogleFonts.mulish(
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Thursday:',
                                      style: GoogleFonts.mulish(
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Friday:',
                                      style: GoogleFonts.mulish(
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Saturday',
                                      style: GoogleFonts.mulish(
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Sunday:',
                                      style: GoogleFonts.mulish(
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 67,
                            ),
                            Column(
                              children: [
                                Text('3:30',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),),
                                Text('3:30',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),),
                                Text('3:30',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),),
                                Text('3:30',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),),
                                Text('3:30',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),),
                                Text('3:30',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),),
                                Text('3:30',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),),
                              ],
                            ),
                          ],
                        ),

                        const Divider(
                          color: Colors.black,
                        ),
                        Row(
                          children:[
                            Column(
                              children:[
                                Text('Time Duration',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),),
                              ],
                            ),
                            const SizedBox(
                              width: 67,
                            ),
                            Column(
                              children:[
                                Text('30 mins',
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
      ),
    );

  }
}
