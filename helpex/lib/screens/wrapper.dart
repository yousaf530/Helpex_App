import 'package:flutter/material.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/authenticate/authenticate.dart';
import 'package:helpex_app/screens/Advisee/advisee_home.dart';
import 'package:helpex_app/screens/Advisor/home.dart';
import 'package:provider/provider.dart';

class Wraper extends StatefulWidget {
  const Wraper({Key? key}) : super(key: key);

  @override
  State<Wraper> createState() => _WraperState();
}

class _WraperState extends State<Wraper> {
  MyUser currentUser = MyUser.getMyUser();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    //auth or home
    if (user?.uid == null) {
      return const Authenticate();
    } else {
      if (currentUser.isAdvisor!) {
        return AdvisorHome();
      } else {
        return AdviseeHome();
      }
    }
  }
}
