import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/db/links.dart';
import 'package:kml/db/post_with_file.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditJobOpp extends StatefulWidget {
  var offer;
  EditJobOpp({required this.offer});

  @override
  State<EditJobOpp> createState() => _EditJobOppState();
}

class _EditJobOppState extends State<EditJobOpp> {
  final TextEditingController name1 = TextEditingController();
  final TextEditingController name2 = TextEditingController();
  File? image;

  GlobalKey<FormState> fkey = new GlobalKey();
  Editjoboffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (fkey.currentState!.validate()) {
      Map data = {
        'content': '${name1.text}',
        'hashtag': '${name2.text}',
        'date': 'ff',
        'profile_id': '${prefs.getString('profile_id')}',
        'id': '${widget.offer['id']}'
      };
      print(data);
      // return;
      if (image != null) {
        var body =
            await postWithMultiFile(editoffers, data, [image!], ['image']);
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
        http.Response response =
            await http.post(Uri.parse(editoffers), body: data);
        var body = jsonDecode(response.body);
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
  }

  @override
  void initState() {
    name1.text = widget.offer['content'];
    name2.text = widget.offer['hashtag'];

    super.initState();
  }

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
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              var res = await ImagePicker.platform
                                  .getImageFromSource(
                                      source: ImageSource.gallery);
                              if (res != null) {
                                image = File(res.path);
                                setState(() {});
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child: image == null
                                  ? Image.network(image_root +
                                      '${widget.offer['image_url']}')
                                  : Image.file(image!),
                            ),
                          )
                        ],
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
                            fun: Editjoboffers,
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
      ),
    );
  }
}
