import 'package:flutter/material.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  TextEditingController grad = TextEditingController();
  TextEditingController work = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                    controller: grad,
                    text: 'Graduated From',
                    textInputType: TextInputType.text,
                    obscure: false),
                SizedBox(
                  height: 20,
                ),
                Textform(
                    controller: work,
                    text: 'Worked At',
                    textInputType: TextInputType.text,
                    obscure: false),
                SizedBox(
                  height: 30,
                ),
                RecButton(
                                color: maincolor,

                    label: Text(
                      'New resume',
                      style: subwfont,
                    ),
                    width: MediaQuery.of(context).size.width - 30,
                    height: 50),
                SizedBox(
                  height: 10,
                ),
                RecButton(
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
    );
  }
}
