import 'package:flutter/material.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/pages/job_offer.dart';

void main() {
  runApp(Klm());
}

class Klm extends StatefulWidget {
  const Klm({super.key});

  @override
  State<Klm> createState() => _KlmState();
}

class _KlmState extends State<Klm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
