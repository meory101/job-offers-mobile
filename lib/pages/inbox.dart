import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kml/components/circular_button.dart';
import 'package:kml/components/comments.dart';
import 'package:kml/components/job_offer.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/db/links.dart';
import 'package:kml/db/load_file.dart';
import 'package:kml/db/post_with_file.dart';
import 'package:kml/pages/show_com_profile.dart';
import 'package:kml/pages/show_emp_profile.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

String? path1;
getPath(file) async {
  print('ffffffff');
  if (file != null) {
    path1 = await loadPDF(image_root + file);
  }
  if (path1 != null) {
    await OpenAppFile.open(path1!);
  }
}

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

String? Type;
String? url;
Check() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Type = prefs.getString('user_id') != null ? 'user' : 'comp';
  print(Type);
}

getInbox() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(Type);
  url = Type == "user"
      ? getuoffers + '/${prefs.getString('user_id')}'
      : getcoffers + '/${prefs.getString('profile_id')}';
  print(url);
  http.Response response = await http.get(Uri.parse(url!));
  var body = jsonDecode(response.body);
  print(body);
  if (body['status'] == 'success') {
    return body['message'];
  }
  return [];
}

class _InboxState extends State<Inbox> {
  @override
  void initState() {
    Check();
    super.initState();
  }

  File? file;
  chooseFile(id) async {
    print('ggggggggggggggggggggggggggggggggggg');
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      file = File(result.files.single.path!);
    }
    if (file != null) {
      var data = {'id': '${id}', 'res': '1'};

      var body = await postWithMultiFile(acceptcv, data, [file!], ['file']);
      if (body['status'] == 'success') {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      // decoration:
      // BoxDecoration(image: DecorationImage(image: AssetImage('bac.jpg'),fit: BoxFit.cover)),
      child: FutureBuilder(
        future: getInbox(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Type == 'user'
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ShowComProfile(
                                            com_id:
                                                '${snapshot.data[index]['com']['message']['company']['id']}',
                                            profile_id:
                                                '${snapshot.data[index]['com']['message']['id']}',
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: ProfileTag(
                                      image: NetworkImage(image_root +
                                          '${snapshot.data[index]['com']['message']['image_url']}'),
                                      name: Text(
                                          '${snapshot.data[index]['com']['message']['company']['name']}'))),
                              SizedBox(
                                height: 10,
                              ),
                              JobOffer(
                                  num: '5',
                                  location: snapshot.data[index]['offerdata']
                                      ['location'],
                                  image: NetworkImage(image_root +
                                      snapshot.data[index]['offerdata']
                                          ['image_url']),
                                  content: snapshot.data[index]['offerdata']
                                      ['content'],
                                  tag: snapshot.data[index]['offerdata']
                                      ['hashtag']),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 6, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'you send cv to this offer..!',
                                        style: greyfont,
                                      ),
                                      '${snapshot.data[index]['data']['res']}' ==
                                              "1"
                                          ? InkWell(
                                              onTap: () async {
                                                print(snapshot.data[index]
                                                    ['data']['file_url']);
                                                await getPath(
                                                    snapshot.data[index]['data']
                                                        ['file_url']);
                                              },
                                              child: CircularButton(
                                                color: Colors.red,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : Text(''),
                                    ],
                                  )),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 1))),
                              )
                            ],
                          ));
                    })
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              JobOffer(
                                  num: '5',
                                  location: snapshot.data[index]['offerdata']
                                      ['location'],
                                  image: NetworkImage(image_root +
                                      snapshot.data[index]['offerdata']
                                          ['image_url']),
                                  content: snapshot.data[index]['offerdata']
                                      ['content'],
                                  tag: snapshot.data[index]['offerdata']
                                      ['hashtag']),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  margin: EdgeInsets.only(
                                      top: 6, left: 20, right: 20),
                                  child: ListView.builder(
                                    itemCount: snapshot
                                        .data[index]['data'].length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 3),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) {
                                                return ShowEmpProfile(
                                                    user_id:
                                                        '${snapshot.data[index]['offerusers'][i]['id']}');
                                              },
                                            ));
                                          },
                                          child: ProfileTag(
                                              image: NetworkImage(image_root +
                                                  '${snapshot.data[index]['usersdata'][i]['message']['image_url']}'),
                                              name: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                          '${snapshot.data[index]['offerusers'][i]['name']} '),
                                                      Text(
                                                        'send you cv',
                                                        style: greyfont,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      print(
                                                          '${snapshot.data[index]['usersdata'][i]['message']['cv_url']}');
                                                      await getPath(
                                                          '${snapshot.data[index]['usersdata'][i]['message']['cv_url']}');
                                                    },
                                                    icon: Icon(
                                                      CupertinoIcons
                                                          .arrow_down_right_square,
                                                      color: maincolor,
                                                    ),
                                                  ),
                                                  '${snapshot.data[index]['data'][i]['res']}' ==
                                                          '0'
                                                      ? Row(
                                                          children: [
                                                            CircularButton(
                                                                color:
                                                                    Colors.red,
                                                                icon: Icon(
                                                                  CupertinoIcons
                                                                      .xmark,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            InkWell(
                                                              child:
                                                                  CircularButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await chooseFile(
                                                                            '${snapshot.data[index]['data'][i]['id']}');
                                                                      },
                                                                      color: Colors
                                                                          .green,
                                                                      icon:
                                                                          Icon(
                                                                        CupertinoIcons
                                                                            .checkmark_circle,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                            ),
                                                          ],
                                                        )
                                                      : Text(''),
                                                ],
                                              )),
                                        ),
                                        // child: Row(
                                        //   children: [
                                        //     CircleAvatar(
                                        //       radius: widget.radius != null
                                        //           ? widget.radius
                                        //           : 20,
                                        //       foregroundColor: bordercolor,
                                        //       backgroundColor: bordercolor,
                                        //       backgroundImage: NetworkImage(image_root+'/${snapshot.data[index]['offerusers']['']}'),
                                        //     ),
                                        //     Padding(
                                        //       padding: EdgeInsets.only(left: 9),
                                        //       child: Text(
                                        //           '${snapshot.data[index]['offerusers'][i]['name']}  send you cv'),
                                        //     )
                                        //   ],
                                        // ),
                                      );
                                    },
                                  )),
                            ],
                          ));
                    });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('you didn\'t apply to offers yet'),
            );
          }
        },
      ),
    )));
  }
}
