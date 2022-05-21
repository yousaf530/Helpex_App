// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:helpex_app/screens/chat/advisorChat.dart';

class AdvisorChatHome extends StatelessWidget {
  final String otherUserID;
  const AdvisorChatHome({Key? key, required this.otherUserID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text("Chating... "),
          backgroundColor: Color(0xff2D7567)),
      body: AdvisorChat(otherUserID: otherUserID),
    );
  }
}
