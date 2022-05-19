// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:helpex_app/authenticate/register.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/screens/Advisee/advisee_home.dart';
//import 'package:helpex_app/screens/Advisee/advisee_home.dart';
import 'package:helpex_app/screens/Advisor/home.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:helpex_app/services/auth.dart';
import 'package:email_validator/email_validator.dart';

class SignIn extends StatefulWidget {
  // final Function toggleView;
  const SignIn({Key? key}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool value = false;
  bool _passwordVisible = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;

  MyUser currentUser = MyUser.getMyUser();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  bool isAdvisor = true;
  bool isAdvisee = false;

  DocumentSnapshot<Map<String, dynamic>>? queryData;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //color: Colors.red,
              child: Column(children: [
                Image.asset(
                  'assets/logo.png',
                  height: 140,
                  width: 140,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 33, 25, 0),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          Material(
                            elevation: 10.0,
                            shadowColor: Colors.grey[100],
                            borderRadius: BorderRadius.circular(40),
                            child: TextFormField(
                              validator: (val) =>
                                  !(EmailValidator.validate(val!))
                                      ? 'Not a valid email.'
                                      : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                                prefixIcon: Icon(Icons.mail_outline),
                                hintText: 'Email',
                                hintStyle: GoogleFonts.mulish(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 10.0,
                            shadowColor: Colors.grey[100],
                            borderRadius: BorderRadius.circular(40),
                            child: TextFormField(
                              obscureText: !_passwordVisible,
                              validator: ((val) => val!.length < 6
                                  ? 'Min password length is 6'
                                  : null),
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                //fillColor: const Color(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                                prefixIcon: Icon(Icons.lock_outline),
                                hintText: 'Password',
                                hintStyle: GoogleFonts.mulish(),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                Text(
                  "Sign In as",
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
                  activeBgColor: [Color(0xff2D7567)],
                  labels: ['Advisor', 'Advisee'],
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
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff2D7567),
                      //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      fixedSize: const Size(325, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result =
                          await _auth.signInWithEmailAndPass(email, password);
                      if (result == null) {
                        setState(() =>
                            error = 'Could not sign in, Check Credentials');
                      } else {
                        var data;
                        final res =
                            await db.collection("Users").doc(result.uid);
                        var querySnapshots = await res.get();
                        data = querySnapshots.data();

                        MyUser currentUser = MyUser.getMyUser();
                        currentUser.dateOfBirth = data["dateOfBirth"];
                        currentUser.email = data["email"];
                        currentUser.name = data["name"];
                        currentUser.uid = data["uid"];
                        currentUser.isAdvisee = data["isAdvisee"];
                        currentUser.isAdvisor = data["isAdvisor"];
                        currentUser.totalEarnings = data["totalEarnings"];
                        print(currentUser.isAdvisor);
                        print("Herheh");
                        if (isAdvisor && currentUser.isAdvisor!) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdvisorHome(),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdviseeHome(),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Text(
                    'Log In',
                    style: GoogleFonts.mulish(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Or",
                  style: GoogleFonts.mulish(textStyle: TextStyle(fontSize: 20)),
                ),
                SizedBox(
                  height: 10,
                ),
                SignInButton(
                  Buttons.Google,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  text: "Sign in with Google",
                  onPressed: () {},
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.mulish(
                            textStyle: TextStyle(fontSize: 15)),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.mulish(),
                        ),
                      ),
                    ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
