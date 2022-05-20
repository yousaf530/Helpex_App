// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helpex_app/authenticate/sign_in.dart';
import 'package:helpex_app/screens/Advisee/advisee_dashboard.dart';
import 'package:helpex_app/screens/Advisor/notification.dart';
import 'package:helpex_app/services/auth.dart';

class AdviseeHome extends StatefulWidget {
  const AdviseeHome({Key? key}) : super(key: key);

  @override
  State<AdviseeHome> createState() => _AdviseeHomeState();
}

class _AdviseeHomeState extends State<AdviseeHome> {
  int currentIndex = 0;

  final screens = [
    AdviseeDashboard(),
    Notifications(),
  ];

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advisee Profile'),
        backgroundColor: Color(0xff2D7567),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            child: TextButton.icon(
              onPressed: () async {
                await _auth.signOut().then(
                      (value) => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      ),
                    );
              },
              icon: Icon(Icons.logout_outlined, color: Colors.white),
              label: Text('Sign Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xff2D7567),
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
