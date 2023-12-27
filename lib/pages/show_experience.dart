import 'package:flutter/material.dart';
import 'package:kml/theme/fonts.dart';

class ShowExp extends StatefulWidget {
  const ShowExp({super.key});

  @override
  State<ShowExp> createState() => _ShowExpState();
}

class _ShowExpState extends State<ShowExp> {
  int selectedindex = 0;
  bool clickedlike = false;
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
                    'Flutter Development',
                    style: lmain,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select your level from A1 English level to C1 English level Reading practice to help you understand long, complex texts about a wide variety Select your level from A1 English level to C1 English level Reading practice to help you understand long, complex texts about a wide variety.",
                    style: greyfont,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' 5 years Experience',
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
