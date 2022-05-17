import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpex_app/models/advisor.dart';
import 'package:helpex_app/models/availability.dart';
import 'package:helpex_app/models/social_media_links.dart';
import 'package:helpex_app/models/uesr_experiences.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:date_field/date_field.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  Advisor advisor = Advisor();
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;

  //form states
  String? description;
  List<String>? experties;
  List<UserExperiences>? userExperience;
  SocialMediaLinks? socialMediaLinks;
  Availability? availability;
  String? rates;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Create Profile',
          style: GoogleFonts.mulish(
            textStyle: TextStyle(
              color: Color(0xff2D7567),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Upload Picture',
                      style: GoogleFonts.mulish(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines:
                                1, //Normal textInputField will be displayed
                            maxLines: 7,
                            decoration: InputDecoration(
                              hintText:
                                  "Write a short description about yourself",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
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
                          TextFormField(
                            decoration: InputDecoration(
                              hintText:
                                  "Write a short description about yourself",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
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
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Company",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Job Title",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              fillColor: Color(0xffFBFBFB),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                          ),
                          DateTimeFormField(
                            decoration: InputDecoration(
                              hintText: "Start Date",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                          ),
                          DateTimeFormField(
                            decoration: InputDecoration(
                              hintText: "End Date",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
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
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Facebook",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "LinkedIn",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
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
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Monday",
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    child: Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tuesday",
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    child: Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Wednesday",
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    child: Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Thursday",
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    child: Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Friday",
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    child: Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Saturday",
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    child: Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Sunday",
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    child: Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: DateTimeFormField(
                                      decoration: InputDecoration(
                                        hintText: "Time",
                                        hintStyle: GoogleFonts.mulish(
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 0.0),
                                        ),
                                      ),
                                      mode: DateTimeFieldPickerMode.time,
                                      autovalidateMode: AutovalidateMode.always,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Time Duration',
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 67,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '30 mins',
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
                  const SizedBox(
                    height: 10,
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
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Price",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Time",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff2D7567),
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  //store data to class and firebase firestore
                                  //db.collection("Users").doc(User.uid);
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
