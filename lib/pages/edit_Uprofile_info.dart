import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/db/links.dart';
import 'package:kml/db/post_with_file.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ProfileInfo extends StatefulWidget {
  String grad;
  String work;

  ProfileInfo({required this.grad, required this.work});
  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  GlobalKey<FormState> fkey = new GlobalKey();

  TextEditingController grad = TextEditingController();
  TextEditingController work = TextEditingController();
  File? file;
  SelectCv() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      file = File(result.files.single.path!);
    }
  }

  UpdateUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {
      'graduated_at': '${grad.text}',
      'worked_at': '${work.text}',
      'user_id': '${prefs.getString('user_id')}',
      'id': '${prefs.getString('profile_id')}'
    };
    var body;
    if (file != null && fkey.currentState!.validate()) {
      body =
          await postWithMultiFile(update_user_profile, data, [file!], ['cv']);
    } else if (file == null && fkey.currentState!.validate()) {
      http.Response responce = await http.post(
        Uri.parse(update_user_profile),
        body: data,
      );
      body = jsonDecode(responce.body);
    }
   if(body!=null){
     print(body);
      if (body['status'] == 'success') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return Home(type: 'user',);
          },
        ));
      }
   }
  }

  @override
  void initState() {
    if (widget.grad != null) {
      grad.text = widget.grad;
    }
    if (widget.work != null) {
      work.text = widget.work;
    }
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Form(
              key: fkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Edit Profile Information!',
                    style: lmain,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Edit university name ,last job and resume .People who visits your profile can see this information.',
                    style: greyfont,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Textform(
                      val: (p0) {
                        print(grad.text);
                        if (grad.text.isNotEmpty) {
                          if (grad.text.length > 20) {
                            return 'too long';
                          } 
                        }
                        else {
                          return 'required';
                        }
                      },
                      controller: grad,
                      text: 'Graduated From',
                      textInputType: TextInputType.text,
                      obscure: false),
                  SizedBox(
                    height: 20,
                  ),
                  Textform(
                      val: (p0) {
                        if (work.text.isNotEmpty) {
                          if (work.text.length > 20) {
                            return 'too long';
                          }
                        }
                         else {
                          return 'required';
                        }
                      },
                      controller: work,
                      text: 'Worked At',
                      textInputType: TextInputType.text,
                      obscure: false),
                  SizedBox(
                    height: 30,
                  ),
                  RecButton(
                      fun: SelectCv,
                      color: maincolor,
                      label: Text(
                        'New cv',
                        style: subwfont,
                      ),
                      width: MediaQuery.of(context).size.width - 30,
                      height: 50),
                  SizedBox(
                    height: 10,
                  ),
                  RecButton(
                      fun: UpdateUserProfile,
                      color: maincolor,
                      label: Text(
                        'Save',
                        style: subwfont,
                      ),
                      width: MediaQuery.of(context).size.width - 30,
                      height: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
