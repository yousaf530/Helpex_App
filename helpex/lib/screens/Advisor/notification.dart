import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatefulWidget {
  const Notifications({ Key? key }) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const SizedBox(
        height: 10,
      ), 
      Text("Appointments",
      style: GoogleFonts.mulish(
                        textStyle:
                            TextStyle(color: Color(0xff2D7567), fontSize: 24, fontWeight: FontWeight.bold),
                      ),),
      const SizedBox(
        height: 10,
      ),              
      ],
          ),
        ),
      ],
      
    );
  }
}