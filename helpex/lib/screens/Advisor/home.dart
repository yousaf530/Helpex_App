// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helpex_app/authenticate/sign_in.dart';
import 'package:helpex_app/screens/Advisor/advisor_calender.dart';
import 'package:helpex_app/screens/Advisor/advisor_chat.dart';
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
  String _title = "";

  final screens = [
    AdvisorDashboard(),
    Notifications(),
    AdvisorCalender(),
    AdvisorProfile()
  ];

  @override
  initState() {
    _title = 'Dashboard';
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff2D7567),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            child: TextButton.icon(
              onPressed: () async {
                await _auth.signOut().then(
                      (value) => Navigator.of(context).pushReplacement(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AdvisorChatScreen(),
            ),
          );
        },
        backgroundColor: Color(0xff2D7567),
        child: const Icon(Icons.chat),
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
        onTap: (index) => setState(() {
          currentIndex = index;
          switch (index) {
            case 0:
              {
                _title = 'Dashboard';
              }
              break;
            case 1:
              {
                _title = 'Notifications';
              }
              break;
            case 2:
              {
                _title = 'Appointments';
              }
              break;
            case 3:
              {
                _title = 'Profile';
              }
              break;
          }
        }),
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
            label: 'Appointments',
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
