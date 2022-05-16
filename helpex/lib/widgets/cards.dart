import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {
  final Widget child;

  const AppCard({Key? key, required this.child}) : super(key: key);

  @override
  _AppCardState createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: widget.child,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
