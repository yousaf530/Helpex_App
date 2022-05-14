import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {
  final Widget child;

  AppCard({Key? key, required this.child}) : super(key: key);

  _AppCardState createState() => _AppCardState();
}

class _AppCardState extends State<AppCard>{
  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: EdgeInsets.all(20.0),
          color: Colors.white,
          child: Container(padding: EdgeInsets.all(20.0),
                  child: widget.child,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                      ),
                    ],
                  ),
          ),
        )
      ],
    );
  }
}
