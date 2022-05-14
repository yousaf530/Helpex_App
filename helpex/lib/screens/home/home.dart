import 'package:flutter/material.dart';
import 'package:login_app/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          TextButton.icon(onPressed: () async {
            await _auth.signOut();
          }, 
          icon: Icon(Icons.person),
          label: Text('logout'),
          )
        ],
      ),
    );
  }
}