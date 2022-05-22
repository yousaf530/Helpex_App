// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:helpex_app/Colors/color.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.name,
    required this.meetTime,
  }) : super(key: key);

  final String name;
  final String meetTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: MyColors.mainColor,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Flexible(
                      child: Text(
                        'Reminder: Meeting with $name at $meetTime  today.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ));
  }
}
