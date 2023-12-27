import 'package:flutter/material.dart';
import 'package:kml/theme/fonts.dart';

class ShowOpp extends StatefulWidget {
  const ShowOpp({super.key});

  @override
  State<ShowOpp> createState() => _ShowOppState();
}

class _ShowOppState extends State<ShowOpp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(right: 10, top: 10),
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/ff.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              width: double.infinity,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.5 - 30,
                  left: 3,
                  right: 3),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.4)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Select your level from A1 English level to C1 English level Reading practice to help you understand long, complex texts about a wide variety Select your level from A1 English level to C1 English level Reading practice to help you understand long, complex texts about a wide variety.",
                    style: greyfont,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '#Flutter Developer',
                    style: submain,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
