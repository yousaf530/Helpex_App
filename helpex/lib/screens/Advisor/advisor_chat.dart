import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvisorChatScreen extends StatefulWidget {
  const AdvisorChatScreen({ Key? key }) : super(key: key);

  @override
  State<AdvisorChatScreen> createState() => _AdvisorChatScreenState();
}

class _AdvisorChatScreenState extends State<AdvisorChatScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: GoogleFonts.mulish(
            textStyle: TextStyle(
              color: Color(0xff2D7567),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}