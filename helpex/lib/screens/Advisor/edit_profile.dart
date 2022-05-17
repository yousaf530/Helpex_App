import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpex_app/models/advisor.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:date_field/date_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  FirebaseFirestore db = FirebaseFirestore.instance;
 // Advisor advisor = Advisor();
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
          'Edit Profile',
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
                    'Change Picture',
                    style: GoogleFonts.mulish(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      fixedSize: const Size(229, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit_pro');
                  },
                  child: Text('Save', style: GoogleFonts.mulish()),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppCard(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name',
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
                          minLines: 1, //Normal textInputField will be displayed
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                                        borderRadius: BorderRadius.circular(40),
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
                        //Row(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
