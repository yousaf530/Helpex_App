import 'package:flutter/material.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class AdvisorDashboard extends StatefulWidget {
  const AdvisorDashboard({Key? key}) : super(key: key);

  @override
  State<AdvisorDashboard> createState() => _AdvisorDashboardState();
}

class _AdvisorDashboardState extends State<AdvisorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Dashboard",
                style: GoogleFonts.mulish(
                  textStyle: const TextStyle(
                      color: Color(0xff2D7567),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 190,
                    child: Column(
                      children: [
                        AppCard(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total\nAppointments',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(
                                        color: Color(0xff2D7567),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color(0xff4BDB6A),
                                  size: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('20',
                                    style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    child: Column(
                      children: [
                        AppCard(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total\nEarnings',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.mulish(
                                    textStyle: const TextStyle(
                                        color: Color(0xff2D7567),

                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.attach_money,
                                  color: Color(0xff4BDB6A),
                                  size: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('20,000',
                                    style: GoogleFonts.mulish(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Todays Bookings',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                              color: Color(0xff2D7567),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Text('Hello 2'),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Upcoming Appointments',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                              color: Color(0xff2D7567),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Text('Hello 2'),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Calendar',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                              color: Color(0xff2D7567),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              AppCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Monthly Earnings',
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                              color: Color(0xff2D7567),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Text('Hello 2'),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
