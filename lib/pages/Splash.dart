import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kml/pages/Login.dart';
import 'package:kml/theme/colors.dart';
  
class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Get.to(Loginpage());
    });
    return Scaffold(
        backgroundColor: maincolor,
        body: Center(
          child: Image.asset("assets/images/logo.jpg"),
        ));
  }
}
