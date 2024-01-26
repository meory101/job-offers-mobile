import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kml/pages/com_profile.dart';
import 'package:kml/pages/Splash.dart';
import 'package:kml/pages/emp_profile.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/pages/home_content.dart';
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
  String? com_id;
  bool log = false;
  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = await prefs.getString('user_id');
    com_id = await prefs.getString('com_id');
    print(user_id);
    print(com_id);
    if (user_id != null || com_id != null) {
      log = true;
      setState(() {});
    }
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
      home: log == false ? SignUp() : Home(type: user_id!=null ?'user' : 'com',),
    );
  }
}
