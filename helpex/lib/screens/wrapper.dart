import 'package:flutter/material.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/authenticate/authenticate.dart';
import 'package:helpex_app/screens/Advisor/home.dart';
import 'package:provider/provider.dart';

class Wraper extends StatefulWidget {
  const Wraper({Key? key}) : super(key: key);

  @override
  State<Wraper> createState() => _WraperState();
}

class _WraperState extends State<Wraper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    //auth or home
    if (user?.uid == null) {
      return const Authenticate();
    } else {
      //to be removed later
      //print(user?.uid);
      return AdvisorHome();
    }
  }
}
