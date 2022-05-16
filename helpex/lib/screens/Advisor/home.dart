// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helpex_app/screens/Advisor/advisor_calender.dart';
import 'package:helpex_app/screens/Advisor/dashboard.dart';
import 'package:helpex_app/screens/Advisor/notification.dart';
import 'package:helpex_app/screens/Advisor/profile.dart';
import 'package:helpex_app/services/auth.dart';

class AdvisorHome extends StatefulWidget {
  const AdvisorHome({Key? key}) : super(key: key);

  @override
  State<AdvisorHome> createState() => _AdvisorHomeState();
}

class _AdvisorHomeState extends State<AdvisorHome> {
  int currentIndex = 0;

  final screens = [
    AdvisorDashboard(),
    Notifications(),
    AdvisorCalender(),
    AdvisorProfile()
  ];

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advisor Profile'),
        backgroundColor: Color(0xff2D7567),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            child: TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
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
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calender',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.white,
          )
        ],
      ),
    );
  }
}
