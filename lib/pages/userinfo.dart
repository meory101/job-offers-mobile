import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:flutter/material.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/db/links.dart';
import 'package:kml/db/post_with_file.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userinfo extends StatelessWidget {
  userinfo({super.key});
    GlobalKey<FormState> fkey = new GlobalKey();

  final TextEditingController s = TextEditingController();
  final TextEditingController s1 = TextEditingController();
  File? image;
  File? cover;
  File? cv;

  SelectImage() async {
    XFile? file = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    if (file != null) {
      return File(file.path);
    } else {
      return null;
    }
  }

  SelectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      cv = File(result.files.single.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    CreateUserProfile() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map data = {
        'user_id': '${prefs.getString('user_id')}',
        'graduated_at': '${s.text}',
        'worked_at': '${s1.text}'
      };
      if (fkey.currentState!.validate()&&
          image != null &&
          cover != null &&
          cv != null) {
        var body = await postWithMultiFile(create_user_profile, data,
            [image!, cover!, cv!], ['image', 'cover', 'cv']);
        if (body['status'] == 'success') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return Home(type: 'user',);
            },
          ));
        }
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
                        controller: s,
                        val: (p0) {
                          if (s.text.isNotEmpty) {
                            if (s.text.length > 20) {
                              return 'too long';
                            }
                          
                          }
                          else{
                              return 'required';
                          }
                        },
                        text: "Graduated from",
                        textInputType: TextInputType.name,
                        obscure: false),
                    SizedBox(
                      height: 20,
                    ),
                    Textform(
                       val: (p0) {
                          if (s.text.isNotEmpty) {
                            if (s.text.length > 20) {
                              return 'too long';
                            }
                          
                          }
                          else{
                              return 'required';
                          }
                        },
                        controller: s1,
                        text: "Worked at",
                        textInputType: TextInputType.name,
                        obscure: false),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: InkWell(
                          child: RecButton(
                              fun: SelectFile,
                              color: maincolor,
                              
                              label: Text(
                                "Add your CV",
                                style: subwfont,
                              ),
                              width: 250,
                              height: 50)),
                    ),
                    Container(
                      width: double.infinity,
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
                          height: 50),
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
                              fun: CreateUserProfile,
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
