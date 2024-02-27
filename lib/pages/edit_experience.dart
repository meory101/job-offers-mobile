import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/db/links.dart';
import 'package:kml/db/post_with_file.dart';
import 'package:kml/pages/home.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditExp extends StatefulWidget {
  var exp;
  EditExp({required this.exp});

  @override
  State<EditExp> createState() => _EditExpState();
}

class _EditExpState extends State<EditExp> {
  final TextEditingController name = TextEditingController();
  final TextEditingController name1 = TextEditingController();
  final TextEditingController name2 = TextEditingController();
  File? image;
  GlobalKey<FormState> fkey = new GlobalKey();

  EditExp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (fkey.currentState!.validate()) {
      Map data = {
        'title': '${name.text}',
        'content': '${name1.text}',
        'years': '${name2.text}',
        'profile_id': '${prefs.getString('profile_id')}',
        'id' : '${widget.exp['id']}'
      };
      if (image != null) {
        var body = await postWithMultiFile(editexp, data, [image!], ['image']);
        if (body['status'] == 'success') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return Home(type: 'user',);
            },
          ));
        }
        setState(() {});
      } else {
        http.Response response =
            await http.post(Uri.parse(editexp), body: data);
        var body = jsonDecode(response.body);
        if (body['status'] == 'success') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return Home(type: 'user',);
            },
          ));
        }
      }
    }
  }

  @override
  void initState() {
    name.text = widget.exp['title'];
    name1.text = widget.exp['content'];
    name2.text = widget.exp['years'];

    super.initState();
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
                              child: image == null
                                  ? Image.network(
                                      image_root + '${widget.exp['image_url']}')
                                  : Image.file(image!),
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
                          if (name.text.isNotEmpty) {
                            if (name.text.length > 20) {
                              return '20 characters only';
                            }
                          } else {
                            return 'required';
                          }
                        },
                        controller: name,
                        text: "Experience Title",
                        textInputType: TextInputType.name,
                        obscure: false),
                    SizedBox(
                      height: 15,
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
                        text: "Experience Content",
                        textInputType: TextInputType.name,
                        obscure: false),
                    SizedBox(
                      height: 15,
                    ),
                    Textform(
                       val: (p0) {
                          if (name2.text.isNotEmpty) {
                            if (int.parse(name2.text) > 50 &&
                                int.parse(name2.text) < 1) {
                              return 'wrong exp years';
                            }
                          } else {
                            return 'required';
                          }
                        },
                        controller: name2,
                        text: "Experience Years",
                        textInputType: TextInputType.number,
                        obscure: false),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                        child: RecButton(
                          fun: EditExp,
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
