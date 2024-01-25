import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';

class companyinfo extends StatelessWidget {
  companyinfo({super.key});
  final TextEditingController s = TextEditingController();
  final TextEditingController s1 = TextEditingController();
  final TextEditingController s2 = TextEditingController();
  File? selectimage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/logo.jpg",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          // height: MediaQuery.of(context).size.height / 3,
                          // child: Icon(Icons.image),
                          child: Text(
                            "Welcome to our Application plesse give us your information ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Textform(
                      controller: s,
                      text: "Work Type",
                      textInputType: TextInputType.name,
                      obscure: false),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: InkWell(
                        child: RecButton(
                          color: maincolor,
                            label: Text(
                              "Add your Location",
                              style: subwfont,
                            ),
                            width: 250,
                            height: 50)),
                  ),
                  Container(
                    width: double.infinity,
                    child: InkWell(
                        child: RecButton(
                          color: maincolor,
                            label: Text(
                              "Tab to Add profile photos",
                              style: subwfont,
                            ),
                            width: 250,
                            height: 50)),
                  ),
                  Container(
                    width: double.infinity,
                    child: InkWell(
                        child: RecButton(
                          color: maincolor,
                            label: Text(
                              "Tab to Add cover photos",
                              style: subwfont,
                            ),
                            width: 250,
                            height: 50)),
                  ),
                  Container(
                    width: double.infinity,
                    child: InkWell(
                        child: RecButton(
                          color: maincolor,
                            label: Text(
                              "Done !",
                              style: subwfont,
                            ),
                            width: 250,
                            height: 50)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
