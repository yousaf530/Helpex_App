import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpex_app/models/advisor.dart';
import 'package:helpex_app/models/availability.dart';
import 'package:helpex_app/models/social_media_links.dart';
import 'package:helpex_app/models/user_experiences.dart';
import 'package:helpex_app/screens/Advisor/home.dart';
import 'package:helpex_app/screens/chat/WriteMessageService.dart';
import 'package:helpex_app/services/create_advisor_data.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:images_picker/images_picker.dart';

class CreateProfile extends StatefulWidget {
  final String uid;

  const CreateProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  Advisor advisor = Advisor.getAdvisor();
  final _formKey = GlobalKey<FormState>();
  String imageUrl = "";
  bool isLoading = false;

  Future getImage() async {
    try {
      List<Media>? res = await ImagesPicker.pick(
        count: 1,
        pickType: PickType.all,
        language: Language.System,
        maxTime: 30,
        // maxSize: 500,
        cropOpt: CropOption(
          // aspectRatio: CropAspectRatio.wh16x9,
          cropType: CropType.circle,
        ),
      );

      if (res != null) {
        uploadFile(res[0].path);
        print(res[0].path);

        setState(() {
          isLoading = true;
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future uploadFile(String path) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = WriteMessageService.uploadFile(path, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.message ?? e.toString());
    }
  }

  //form states
  String description = "";
  String experties = "";
  UserExperiences userExperience = UserExperiences(onGoing: false);
  SocialMediaLinks socialMediaLinks = SocialMediaLinks();
  Availability availability = Availability();
  String rates = "";
  String ratesTime = "";
  String? uid = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Profile",
          style: GoogleFonts.mulish(
            textStyle: TextStyle(
              color: Color(0xff2D7567),
              fontWeight: FontWeight.bold,
              fontSize: 20,
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
                    onPressed: getImage,
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
                            validator: (value) =>
                                value!.isEmpty ? 'Required' : null,
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
                            onChanged: (value) {
                              setState(() => description = value);
                            },
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
                              hintText: "Write Your Expertise",
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
                            onChanged: (value) {
                              setState(() => experties = value);
                            },
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
                            validator: ((value) {
                              value!.isEmpty ? 'Required' : null;
                            }),
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
                            onChanged: (val) {
                              setState(() => userExperience.companyName = val);
                            },
                          ),
                          TextFormField(
                            validator: ((value) {
                              value!.isEmpty ? 'Required' : null;
                            }),
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
                            onChanged: (val) {
                              setState(() => userExperience.jobTitle = val);
                            },
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
                            onDateSelected: (DateTime value) {
                              userExperience.startDate =
                                  DateFormat("yyyy-MM-dd").format(value);
                            },
                          ),
                          DateTimeFormField(
                            enabled: !userExperience.onGoing,
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
                            onDateSelected: (DateTime value) {
                              userExperience.endDate =
                                  DateFormat("yyyy-MM-dd").format(value);
                            },
                          ),
                          CheckboxListTile(
                            title: Text("On Going Job"),
                            value: userExperience.onGoing,
                            onChanged: (bool? value) {
                              setState(() {
                                userExperience.onGoing = value!;
                              });
                            },
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
                            validator: ((value) =>
                                Uri.tryParse(value!)!.hasAbsolutePath
                                    ? 'Not a valid URL'
                                    : null),
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
                            onChanged: (val) {
                              setState(() => socialMediaLinks.facebook = val);
                            },
                          ),
                          TextFormField(
                            validator: ((value) =>
                                Uri.tryParse(value!)!.hasAbsolutePath
                                    ? 'Not a valid URL'
                                    : null),
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
                            onChanged: (val) {
                              setState(() => socialMediaLinks.linkedin = val);
                            },
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
                                      onDateSelected: (DateTime value) {
                                        availability.mondayStart =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.mondayEnd =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.tuesdayStart =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.tuesdayEnd =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.wednesdayStart =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.wednesdayEnd =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.thursdayStart =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.thursdayEnd =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.fridayStart =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.fridayEnd =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.saturdayStart =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.saturdayEnd =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.sundayStart =
                                            DateFormat.Hm().format(value);
                                      },
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
                                      onDateSelected: (DateTime value) {
                                        availability.sundayEnd =
                                            DateFormat.Hm().format(value);
                                      },
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
                            validator: (value) =>
                                value!.isEmpty ? 'Required' : null,
                            keyboardType: TextInputType.number,
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
                            onChanged: (val) {
                              setState(() => rates = val);
                            },
                          ),
                          TextFormField(
                              validator: (value) =>
                                  value!.isEmpty ? 'Required' : null,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Time",
                                hintStyle: GoogleFonts.mulish(
                                  textStyle: TextStyle(color: Colors.grey),
                                ),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                              onChanged: (value) {
                                ratesTime = value.toString();
                              }),
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
                                  AdvisorToFirestore toFirestore =
                                      AdvisorToFirestore(
                                          availability: availability,
                                          description: description,
                                          rates: rates,
                                          socialMediaLinks: socialMediaLinks,
                                          uid: widget.uid,
                                          ratesTime: ratesTime,
                                          userExperience: userExperience,
                                          expertise: experties,
                                          profilePicUrl: imageUrl);
                                  toFirestore.newAdvisorDataToFirebase();

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AdvisorHome()));

                                  print(widget.uid);
                                } else {
                                  print("Validation Error");
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
