import 'package:flutter/material.dart';
import 'package:helpex_app/widgets/cards.dart';

class AdvisorDashboard extends StatefulWidget {
  const AdvisorDashboard({Key? key}) : super(key: key);

  @override
  State<AdvisorDashboard> createState() => _AdvisorDashboardState();
}

class _AdvisorDashboardState extends State<AdvisorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AppCard(
            child: Text("what the fuck"),
          ),
        )
      ],
    ));
  }
}
