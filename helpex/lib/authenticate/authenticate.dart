import 'package:flutter/material.dart';
import 'package:helpex_app/authenticate/register.dart';
import 'package:helpex_app/authenticate/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn();
    } else {
      return Register();
    }
  }
}
