import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helpex_app/authenticate/sign_in.dart';
import 'package:helpex_app/screens/wrapper.dart';
import 'package:helpex_app/services/auth.dart';
import 'package:helpex_app/state/userModel.dart';
import 'package:provider/provider.dart';
import 'package:helpex_app/screens/Advisor/edit_profile.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  MyUser helpUser = MyUser();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel(user: helpUser)),
        StreamProvider<MyUser?>.value(
          initialData: null,
          value: AuthService().user,
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          //primarySwatch: Colors.blue,
          fontFamily: 'mulish',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wraper(),
          '/edit_pro': (context) => const EditProfile(),
        },
        // home: Wraper(),
      ),
    );
  }
}
