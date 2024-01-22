import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';

class EditJobOpp extends StatefulWidget {
  EditJobOpp({super.key});

  @override
  State<EditJobOpp> createState() => _EditJobOppState();
}

class _EditJobOppState extends State<EditJobOpp> {
  final TextEditingController name = TextEditingController();
  final TextEditingController name1 = TextEditingController();
  final TextEditingController name2 = TextEditingController();
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
                          child: Icon(Icons.image),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Textform(
                      controller: name1,
                      text: "Job Opportunity Content",
                      textInputType: TextInputType.name,
                      obscure: false),
                  SizedBox(
                    height: 15,
                  ),
                  Textform(
                      controller: name2,
                      text: "#Job Name",
                      textInputType: TextInputType.name,
                      obscure: false),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      child: RecButton(
                                color: maincolor,

                          label: Text(
                            "Tab to Update",
                            style: subwfont,
                          ),
                          width: 250,
                          height: 50)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
