import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'alertChat.dart';

class AdvisorChatHome extends StatelessWidget {
    final String otherUserID;
  const AdvisorChatHome({ Key? key,required this.otherUserID }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Chating... "),),
      body:  AdviseeChat( otherUserID:otherUserID),
    );
  }
}