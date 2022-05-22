import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpex_app/models/advisor.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/screens/Advisor/home.dart';
import 'package:helpex_app/screens/chat/WriteMessageService.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:date_field/date_field.dart';
import 'package:images_picker/images_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isData = false;
  late final profile;
  late final experience;
  late final socials;
  late final availability;
  bool isLoading = false;
  String imageUrl = "";
  MyUser currentUser = MyUser.getMyUser();
  final Advisor advisor = Advisor.getAdvisor();
  FirebaseFirestore db = FirebaseFirestore.instance;

  String selectImage = "Not Selected!";

  late TextEditingController aboutMeController;
  late TextEditingController expertiseController;
  late TextEditingController experienceCompanyController;
  late TextEditingController experienceJobController;
  late TextEditingController socialFacebookController;
  late TextEditingController socialLinkedinController;
  late TextEditingController ratesCostController;
  late TextEditingController ratesTimeController;

  addValuesToController() {
    aboutMeController = TextEditingController(text: profile["description"]);
    expertiseController = TextEditingController(text: profile["expertise"]);
    experienceCompanyController =
        TextEditingController(text: experience["companyName"]);
    experienceJobController =
        TextEditingController(text: experience["jobTitle"]);
    socialFacebookController = TextEditingController(text: socials["facebook"]);
    socialLinkedinController = TextEditingController(text: socials["linkedin"]);
    ratesCostController = TextEditingController(text: profile["rates"]);
    ratesTimeController = TextEditingController(text: profile["ratesTime"]);
  }

  //editing controllers

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
      selectImage = "Done";
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  readProfile() async {
    try {
      final result = await db.collection("Advisor").doc(currentUser.uid).get();
      var data = result.data();
      print("${data!["description"]}");
      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  readExperience() async {
    try {
      var data;
      final result =
          db.collection("Experience").where("uid", isEqualTo: currentUser.uid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  readSocials() async {
    try {
      var data;
      final result =
          db.collection("Social").where("uid", isEqualTo: currentUser.uid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  readAvailability() async {
    try {
      var data;
      final result = db
          .collection("Availability")
          .where("uid", isEqualTo: currentUser.uid);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.data();
      }

      return data;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  getData() async {
    profile = await readProfile();
    experience = await readExperience();
    socials = await readSocials();
    availability = await readAvailability();
    imageUrl = profile["profilePicUrl"];
    addValuesToController();
    //DateTime.parse("${availability["mondayStart"]}");
    setState(() {
      isData = true;
    });
  }

  updateProfile() async {
    await db.collection("Advisor").doc(currentUser.uid).update({
      "description": aboutMeController.text,
      "expertise": expertiseController.text,
      "profilePicUrl": imageUrl,
      "rates": ratesCostController.text,
      "ratesTime": ratesTimeController.text,
      "expertiesList": expertiseController.text.toLowerCase().replaceAll(',', '').split(' ')
    });

    String experienceId = "";
    String socialId = "";
    final result =
        db.collection("Experience").where("uid", isEqualTo: currentUser.uid);
    var querySnapshots = await result.get();
    for (var snapshot in querySnapshots.docs) {
      experienceId = snapshot.id;
    }

    final result2 =
        db.collection("Experience").where("uid", isEqualTo: currentUser.uid);
    var querySnapshots2 = await result2.get();
    for (var snapshot in querySnapshots2.docs) {
      socialId = snapshot.id;
    }

    await db.collection("Experience").doc(experienceId).update({
      "companyName": experienceCompanyController.text,
      "jobTitle": experienceJobController.text
    });

    await db.collection("Social").doc(socialId).update({
      "facebook": socialFacebookController.text,
      "linkedin": socialLinkedinController
    });

    //isLoading
  }

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
      body: isData == false
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                        backgroundColor: Colors.grey[400],
                        radius: 62.5,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: getImage,
                        child: Text(
                          'Change Picture',
                          style: GoogleFonts.mulish(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        profile["name"],
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                          updateProfile();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => AdvisorHome(),
                            ),
                          );
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
                                controller: aboutMeController,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 7,
                                decoration: InputDecoration(
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
                                controller: expertiseController,
                                decoration: InputDecoration(
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
                                controller: experienceCompanyController,
                                decoration: InputDecoration(
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
                              ),
                              TextFormField(
                                controller: experienceJobController,
                                decoration: InputDecoration(
                                  hintStyle: GoogleFonts.mulish(
                                    textStyle: TextStyle(color: Colors.grey),
                                  ),
                                  fillColor: Color(0xffFBFBFB),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 0.0),
                                  ),
                                ),
                              ),
                              DateTimeFormField(
                                //initialValue: experience["startDate"],
                                decoration: InputDecoration(
                                  hintText: "Start Date",
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
                                mode: DateTimeFieldPickerMode.date,
                                autovalidateMode: AutovalidateMode.always,
                              ),
                              DateTimeFormField(
                                //initialValue: experience["endDate"],
                                decoration: InputDecoration(
                                  hintText: "End Date",
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
                                controller: socialFacebookController,
                                decoration: InputDecoration(
                                  hintText: "Facebook",
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
                              ),
                              TextFormField(
                                controller: socialLinkedinController,
                                decoration: InputDecoration(
                                  hintText: "LinkedIn",
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
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // AppCard(
                      //   child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Availability',
                      //           style: GoogleFonts.mulish(
                      //             textStyle: const TextStyle(
                      //                 color: Color(0xff2D7567),
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ),
                      //         const Divider(
                      //           color: Colors.black,
                      //         ),
                      //         Column(
                      //           children: [
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   "Monday",
                      //                   style: GoogleFonts.mulish(
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontSize: 16),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue: DateTime.parse(
                      //                         availability["mondayStart"]),
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                   child: Text("-",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold)),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["mondayEnd"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   "Tuesday",
                      //                   style: GoogleFonts.mulish(
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontSize: 16),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["tuesdayStart"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                   child: Text("-",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold)),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["tuesdayEnd"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   "Wednesday",
                      //                   style: GoogleFonts.mulish(
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontSize: 16),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["wednesdayStart"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                   child: Text("-",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold)),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["wednesdayEnd"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   "Thursday",
                      //                   style: GoogleFonts.mulish(
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontSize: 16),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["thursdayStart"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                   child: Text("-",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold)),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["thursdayEnd"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   "Friday",
                      //                   style: GoogleFonts.mulish(
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontSize: 16),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["fridayStart"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                   child: Text("-",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold)),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["fridayEnd"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   "Saturday",
                      //                   style: GoogleFonts.mulish(
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontSize: 16),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["saturdayStart"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                   child: Text("-",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold)),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["saturdayEnd"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   "Sunday",
                      //                   style: GoogleFonts.mulish(
                      //                     textStyle: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontSize: 16),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["sundayStart"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: const BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                   child: Text("-",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold)),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   child: DateTimeFormField(
                      //                     initialValue:
                      //                         availability["sundayEnd"],
                      //                     decoration: InputDecoration(
                      //                       hintText: "Time",
                      //                       hintStyle: GoogleFonts.mulish(
                      //                         textStyle:
                      //                             TextStyle(color: Colors.grey),
                      //                       ),
                      //                       border: InputBorder.none,
                      //                       enabledBorder: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(40),
                      //                         borderSide: BorderSide(
                      //                             color: Colors.white,
                      //                             width: 0.0),
                      //                       ),
                      //                     ),
                      //                     mode: DateTimeFieldPickerMode.time,
                      //                     autovalidateMode:
                      //                         AutovalidateMode.always,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ]),
                      // ),
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
                                controller: ratesCostController,
                                decoration: InputDecoration(
                                  hintText: "Price",
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
                              ),
                              TextFormField(
                                controller: ratesTimeController,
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
