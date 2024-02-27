import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/db/links.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/pages/map.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CProfileInfo extends StatefulWidget {
  String work;
  String lat;
  String long;

  CProfileInfo({required this.work, required this.lat, required this.long});

  @override
  State<CProfileInfo> createState() => _CProfileInfoState();
}

class _CProfileInfoState extends State<CProfileInfo> {
  GlobalKey<FormState> fkey = new GlobalKey();
  String? latlong;
  TextEditingController work = TextEditingController();
  UpdateCompanyprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = {
      'id': '${prefs.getString('profile_id')}',
      'wo': '${work.text}',
      'lat': latlong == null ? widget.lat : '${latlong!.split('*')[0]}',
      'long': latlong ==null ? widget.long : '${latlong!.split('*')[1]}',
      'com_id': '${prefs.getString('com_id')}'
    };
    print(data);
    var body;

    if (fkey.currentState!.validate()) {
      http.Response responce = await http.post(
        Uri.parse(update_comp_profile),
        body: data,
      );
      body = jsonDecode(responce.body);
    }
    if (body != null) {
      print(body);
      if (body['status'] == 'success') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return Home(
              type: 'com',
            );
          },
        ));
      }
    }
  }

  @override
  void initState() {
    if (widget.work != null) {
      work.text = widget.work;
    }
    latlong = null;

    super.initState();
  }

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
                      controller: work,
                      text: 'Work Type',
                      textInputType: TextInputType.text,
                      obscure: false),
                  SizedBox(
                    height: 20,
                  ),
                  RecButton(
                      fun: () async {
                        latlong =
                            await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Map(lat: widget.lat, long: widget.long);
                          },
                        ));
                      },
                      color: maincolor,
                      label: Text(
                        'Location',
                        style: subwfont,
                      ),
                      width: MediaQuery.of(context).size.width - 30,
                      height: 50),
                  SizedBox(
                    height: 10,
                  ),
                  RecButton(
                      fun: UpdateCompanyprofile,
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
