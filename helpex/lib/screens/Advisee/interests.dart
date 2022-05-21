import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpex_app/screens/Advisee/advisee_home.dart';

class Interests {
  const Interests(this.name);
  final String name;
}

class AdviseeInterests extends StatefulWidget {
  const AdviseeInterests({Key? key}) : super(key: key);

  @override
  State createState() => AdviseeInterestsState();
}

class AdviseeInterestsState extends State<AdviseeInterests> {
  final List<Interests> _cast = <Interests>[
    const Interests('Web Development'),
    const Interests('Python'),
    const Interests('Machine Learning'),
    const Interests('Java'),
    const Interests('C++'),
    const Interests('Deep Learning'),
    const Interests('Data Science'),
    const Interests('Flutter'),
    const Interests('Game Development'),
    const Interests('Maths'),
    const Interests('Javascript'),
    const Interests('C'),
    const Interests('Data Analytics'),
    const Interests('Animation'),
    const Interests('Software Engineering'),
    const Interests('C#'),
    const Interests('SQL'),
    const Interests('Mechanics'),
    const Interests('Physics'),
    const Interests('Statistics'),
    const Interests('Chemistry'),
    const Interests('Excel'),
    const Interests('R'),
  ];
  final List<String> _filters = <String>[];

  Iterable<Widget> get interestsWidgets {
    return _cast.map((Interests field) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          elevation: 10.0,
          shadowColor: Colors.grey[100],
          borderRadius: BorderRadius.circular(40),
          child: FilterChip(
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                field.name,
                style: GoogleFonts.mulish(
                    color: Color(0xff2D7567),
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            selected: _filters.contains(field.name),
            backgroundColor: Colors.white,
            selectedColor: Color(0xffD6FEFF),
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  _filters.add(field.name);
                } else {
                  _filters.removeWhere((String name) {
                    return name == field.name;
                  });
                }
              });
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/Ellipse.png',
                      width: double.infinity,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          "What are your interests?",
                          style: GoogleFonts.mulish(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: interestsWidgets.toList(),
                  ),
                ),
                Text('Look for: ${_filters.join(', ')}'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff2D7567),
                      fixedSize: const Size(325, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AdviseeHome()));
                  },
                  child: Text('Next',
                      style: GoogleFonts.mulish(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
