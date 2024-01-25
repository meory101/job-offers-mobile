import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kml/pages/com_profile.dart';
import 'package:kml/pages/Splash.dart';
import 'package:kml/pages/emp_profile.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/pages/job_offer.dart';
import 'package:kml/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Klm());
}

class Klm extends StatefulWidget {
  const Klm({super.key});

  @override
  State<Klm> createState() => _KlmState();
}

class _KlmState extends State<Klm> {
  String? user_id;
  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = await prefs.getString('user_id');
    setState(() {});
    print(user_id);
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: user_id == null ? SignUp() : Home(),
    );
  }
}
