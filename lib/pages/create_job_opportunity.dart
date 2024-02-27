import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/db/links.dart';
import 'package:kml/db/post_with_file.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Create_new extends StatefulWidget {
  @override
  State<Create_new> createState() => _Create_newState();
}

class _Create_newState extends State<Create_new> {
  File? image;
  final TextEditingController name1 = TextEditingController();
  final TextEditingController name2 = TextEditingController();

  GlobalKey<FormState> fkey = new GlobalKey();
  Createjoboffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (fkey.currentState!.validate()) {
      Map data = {
        'content': '${name1.text}',
        'date': '${Jiffy.now().yMMMMd}',
        'hashtag': '${name2.text}',
        'profile_id': '${prefs.getString('profile_id')}',
      };
      print(data);
      print(image);
      if (image != null) {
        var body =
            await postWithMultiFile(createoffers, data, [image!], ['image']);
        if (body['status'] == 'success') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return Home(
                type: 'com',
              );
            },
          ));
        }
        setState(() {});
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'Image is required',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: fkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        var res = await ImagePicker.platform
                            .getImageFromSource(source: ImageSource.gallery);
                        if (res != null) {
                          image = File(res.path);
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child: image != null
                                  ? Image.file(image!)
                                  : Icon(Icons.image),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Textform(
                        val: (p0) {
                          if (name1.text.isNotEmpty) {
                            if (name1.text.length > 100) {
                              return '100 characters only';
                            }
                          } else {
                            return 'required';
                          }
                        },
                        controller: name1,
                        text: "Job Opportunity Content",
                        textInputType: TextInputType.name,
                        obscure: false),
                    SizedBox(
                      height: 15,
                    ),
                    Textform(
                        val: (p0) {
                          if (name2.text.isNotEmpty) {
                            if (name2.text.length > 20) {
                              return '20 characters only';
                            }
                          } else {
                            return 'required';
                          }
                        },
                        controller: name2,
                        text: "#Job Name",
                        textInputType: TextInputType.name,
                        obscure: false),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                        child: RecButton(
                            fun: Createjoboffers,
                            color: maincolor,
                            label: Text(
                              "Tab to Add",
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
      ),
    );
  }
}
