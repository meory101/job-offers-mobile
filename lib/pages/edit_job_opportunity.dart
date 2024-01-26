import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart'as http;
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
  final TextEditingController name = TextEditingController();
  final TextEditingController name1 = TextEditingController();
  final TextEditingController name2 = TextEditingController();
    File? image;
 
    GlobalKey<FormState> fkey = new GlobalKey();
  Editjoboffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (fkey.currentState!.validate()) {
      Map data = {
        'title': '${name.text}',
        'job_name': '${name1.text}',
         'profile_id': '${prefs.getString('profile_id')}',
        'id': '${widget.offer['id']}'
      };
      if (image != null) {
        var body = await postWithMultiFile(editexp, data, [image!], ['image']);
        if (body['status'] == 'success') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return Home();
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
              return Home();
            },
          ));
        }
      }
    }
  }

  @override
    void initState() {
    name.text = widget.offer['title'];
    name1.text = widget.offer['job_name'];
 
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
                             Container(
                            height: MediaQuery.of(context).size.height / 3,
                            child:    image == null
                                  ? Image.network(
                                      image_root + '${widget.offer['image_url']}')
                                  : Image.file(image!),
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
      ),
    );
  }
}
