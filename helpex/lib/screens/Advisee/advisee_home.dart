import 'package:flutter/material.dart';
import 'package:helpex_app/widgets/cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AdviseeHome extends StatefulWidget {
  const AdviseeHome({Key? key}) : super(key: key);

  @override
  State<AdviseeHome> createState() => _AdviseeHomeState();
}

class _AdviseeHomeState extends State<AdviseeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: GoogleFonts.mulish(
            textStyle: TextStyle(
              color: Color(0xff2D7567),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Material(
                    elevation: 10.0,
                    shadowColor: Colors.grey[100],
                    borderRadius: BorderRadius.circular(40),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        suffixIcon: Icon(Icons.search_outlined,
                          color: Color(0xff2D7567),
                        ),
                        hintText: 'Search',
                        hintStyle: GoogleFonts.mulish(
                          textStyle: TextStyle(fontSize: 20)
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        //backgroundImage: (),
                        backgroundColor: Colors.grey[400],
                        radius: 62.5,
                        child: const Text(
                          'poop',
                          style: TextStyle(color: Colors.white),
                        ), //Text
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Advisor Name",
                        style: GoogleFonts.mulish(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.money_outlined,
                            color: Color(0xff2D7567),
                            size: 30.0,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Rs. 20,000",
                            style: GoogleFonts.mulish(
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 10,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff2D7567),
                            fixedSize: const Size(220, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {

                        },
                        child: Text('Book an Appointment',
                            style: GoogleFonts.mulish(
                              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: const Size(220, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            side: BorderSide(
                              width: 2.0,
                              color: Color(0xff2D7567),
                            ),
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/view_advisor_pro');
                        },
                        child: Text('View Profile',
                            style: GoogleFonts.mulish(
                              textStyle: TextStyle(
                                  color: Color(0xff2D7567), fontSize: 18, fontWeight: FontWeight.w600),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
