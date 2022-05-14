import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helpex_app/screens/wrapper.dart';
import 'package:helpex_app/services/auth.dart';
import 'package:provider/provider.dart';


import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          //primarySwatch: Colors.blue,
          fontFamily: 'mulish',
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const Wraper(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          // '/signUp': (context) => Register(toggleView: toggleView),
        },
        // home: Wraper(),
      ),
    );
  }
}
