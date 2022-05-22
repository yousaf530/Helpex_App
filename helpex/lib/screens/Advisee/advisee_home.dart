// ignore_for_file: prefer_const_constructors, must_call_super

import 'package:flutter/material.dart';
import 'package:helpex_app/authenticate/sign_in.dart';
import 'package:helpex_app/screens/Advisee/advisee_dashboard.dart';
import 'package:helpex_app/screens/Advisee/all_chats.dart';
import 'package:helpex_app/screens/Advisee/appointments_tab.dart';
import 'package:helpex_app/screens/Advisee/notification.dart';
import 'package:helpex_app/services/auth.dart';

class AdviseeHome extends StatefulWidget {
  const AdviseeHome({Key? key}) : super(key: key);

  @override
  State<AdviseeHome> createState() => _AdviseeHomeState();
}

class _AdviseeHomeState extends State<AdviseeHome> {
  int currentIndex = 0;
  String _title = "";

  final screens = [
    AdviseeDashboard(),
    AdviseeNotifications(),
    AllChats(),
    AdviseeAppointments()
  ];

  final AuthService _auth = AuthService();

  @override
  initState() {
    _title = 'Dashboard';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
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
                _title = 'Chats';
              }
              break;
            case 3:
              {
                _title = 'Appointments';
              }
              break;
          }
        }),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Appointments',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
