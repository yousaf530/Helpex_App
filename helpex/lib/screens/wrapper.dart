import 'package:flutter/material.dart';
import 'package:helpex_app/models/user.dart';
import 'package:helpex_app/authenticate/authenticate.dart';
import 'package:helpex_app/screens/Advisee/advisee_home.dart';
import 'package:helpex_app/screens/Advisor/home.dart';
//import 'package:helpex_app/services/auth.dart';
import 'package:provider/provider.dart';

class Wraper extends StatefulWidget {
  const Wraper({Key? key}) : super(key: key);

  @override
  State<Wraper> createState() => _WraperState();
}

class _WraperState extends State<Wraper> {
  MyUser currentUser = MyUser.getMyUser();
 // final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    //auth or home
    if (currentUser.uid != user?.uid) {
      return const Authenticate();
    }else if(currentUser.uid == null && user?.uid != null){
      //await _auth.signOut();
      return const Authenticate();
    } 
    else {
      if (currentUser.isAdvisor! == true) {
        return AdvisorHome();
      } else if(currentUser.isAdvisee! == true){
        return AdviseeHome();
      } else {
        return const Authenticate();
      }
    }
  }
}
