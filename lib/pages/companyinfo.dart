import 'dart:io';
import 'package:kml/pages/map.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/db/links.dart';
import 'package:kml/db/post_with_file.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/pages/signup.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class companyinfo extends StatelessWidget {
  companyinfo({super.key});
  final TextEditingController s = TextEditingController();
  GlobalKey<FormState> fkey = new GlobalKey();
  String? latlong;
  File? image;
  File? cover;
  SelectImage() async {
    XFile? file = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    if (file != null) {
      return File(file.path);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    CreateComProfile() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    
      if (fkey.currentState!.validate() &&
          image != null &&
          cover != null &&
          latlong != null) {
             List<String> latlong1 = latlong!.split('*');
        var data = {
          'company_id': '${prefs.getString('com_id')}',
          'work_type': '${s.text}',
          'lat': '${latlong1[0]}',
          'long': '${latlong1[1]}',
        };
        try {
          var body = await postWithMultiFile(
              create_com_profile, data, [image!, cover!], ['image', 'cover']);
          print(body);
          if (body['status'] == 'success') {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return Home(
                  type: "comp",
                );
              },
            ));
          }
        } catch (e) {}
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'Fileds are required',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }
    }

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
                        val: (p0) {
                          if (s.text.isNotEmpty) {
                            if (s.text.length > 20) {
                              return 'too long';
                            }
                          } else {
                            return 'required';
                          }
                        },
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
                              fun: () async {
                                latlong = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) {
                                    return Map();
                                  },
                                ));
                                print(latlong);
                              },
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
                              fun: () async {
                                image = await SelectImage();
                              },
                              color: maincolor,
                              label: Text(
                                "Tab to Add profile photo",
                                style: subwfont,
                              ),
                              width: 250,
                              height: 50)),
                    ),
                    Container(
                      width: double.infinity,
                      child: InkWell(
                          child: RecButton(
                              fun: () async {
                                cover = await SelectImage();
                              },
                              color: maincolor,
                              label: Text(
                                "Tab to Add cover photo",
                                style: subwfont,
                              ),
                              width: 250,
                              height: 50)),
                    ),
                    Container(
                      width: double.infinity,
                      child: InkWell(
                          child: RecButton(
                              fun: CreateComProfile,
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
      ),
    );
  }
}
