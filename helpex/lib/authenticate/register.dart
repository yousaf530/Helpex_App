// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:helpex_app/authenticate/sign_in.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/screens/Advisee/interests.dart';
import 'package:helpex_app/screens/Advisor/create_profile.dart';
import 'package:helpex_app/services/auth.dart';
import 'package:date_field/date_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Register extends StatefulWidget {
  //final Function toggleView;
  const Register({Key? key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  MyUser user = MyUser.getMyUser();
  final AuthService _auth = AuthService();
  //FirebaseAuth authF = FirebaseAuth.instance;
  //User? userF = authF.currentUser;
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  String dateOfBirth = '';
  bool isAdvisee = false;
  bool isAdvisor = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'HelpEx',
          style: GoogleFonts.mulish(
            textStyle: TextStyle(
              color: Color(0xff2D7567),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 35, top: 20),
                    child: Text(
                      'Create\nAccount',
                      style: GoogleFonts.mulish(
                        textStyle:
                            TextStyle(color: Color(0xff2D7567), fontSize: 33),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? 'Enter Name' : null,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Full Name",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) => !(EmailValidator.validate(val!))
                              ? 'Not a valid email.'
                              : null,
                          style: GoogleFonts.mulish(
                            textStyle: TextStyle(color: Colors.black),
                          ),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Email",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: !_passwordVisible,
                          validator: ((val) => val!.length < 6
                              ? 'Min password length is 6'
                              : null),
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != password) {
                              return 'Passwords Don\'t match';
                            } else {
                              return null;
                            }
                          },
                          obscureText: !_passwordVisible,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Confirm Password",
                              hintStyle: GoogleFonts.mulish(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DateTimeFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'Date of Birth',
                            labelStyle: GoogleFonts.mulish(
                              textStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.always,
                          onDateSelected: (DateTime value) {
                            //print(value);

                            dateOfBirth =
                                DateFormat("yyyy-MM-dd").format(value);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sign Up as",
                          style: GoogleFonts.mulish(
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ToggleSwitch(
                          initialLabelIndex: 0,
                          totalSwitches: 2,
                          minWidth: 90.0,
                          cornerRadius: 20.0,
                          radiusStyle: true,
                          activeBgColor: const [Color(0xff2D7567)],
                          labels: const ['Advisor', 'Advisee'],
                          onToggle: (index) {
                            if (index == 0) {
                              isAdvisor = true;
                              isAdvisee = false;
                            } else if (index == 1) {
                              isAdvisor = false;
                              isAdvisee = true;
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
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
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      dynamic result =
                                          await _auth.registerWithEmailAndPass(
                                              email, password);
                                      if (result == null) {
                                        setState(() => error =
                                            'please supply valid email');
                                      } else {
                                        //make User here
                                        user.withAllInfo(
                                            uid: result.uid,
                                            name: name,
                                            email: email,
                                            dateOfBirth: dateOfBirth,
                                            isAdvisee: isAdvisee,
                                            isAdvisor: isAdvisor);

                                        if (isAdvisor) {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateProfile(
                                                          uid: user.uid
                                                              .toString())));
                                        } else {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdviseeInterests()));
                                        }
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Already have an account?",
                                style: GoogleFonts.mulish(
                                    textStyle: TextStyle(fontSize: 15)),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  //widget.toggleView();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SignIn(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.mulish(),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
