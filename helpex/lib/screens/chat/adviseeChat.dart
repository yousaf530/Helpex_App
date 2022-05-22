import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'alertChat.dart';

class AdviseeChatHome extends StatelessWidget {
  final String otherUserID;
  const AdviseeChatHome({Key? key, required this.otherUserID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatting... "),
        backgroundColor: Color(0xff2D7567),
      ),
      body: AdviseeChat(otherUserID: otherUserID),
    );
  }
}
