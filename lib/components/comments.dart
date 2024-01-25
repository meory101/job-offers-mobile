import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kml/components/Text_form.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/db/links.dart';
import 'package:kml/pages/show_emp_profile.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentsSection extends StatefulWidget {
  String offerid;
  CommentsSection({super.key, required this.offerid});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  TextEditingController com = TextEditingController();
  GetComments() async {
    String url = '$getComments/${widget.offerid}';
    http.Response response = await http.get(Uri.parse(url));

    var body = jsonDecode(response.body);
    if (body['status'] == 'success') {
      return body['message'];
    }
    return null;
  }

  String? type;
  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString('user_id');
  }

  AddComment() async {
    String url = addcomment;
   if(com.text.isNotEmpty){
      http.Response response = await http.post(Uri.parse(url), body: {
        'content': com.text,
        'offer_id': widget.offerid,
        'user_id': '$type'
      });

      var body = jsonDecode(response.body);
      if (body['status'] == 'success') {
        com.clear();
        GetComments();
        setState(() {});
      }
   }
  }

  @override
  void initState() {
    getUserType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetComments(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length + 2,
              itemBuilder: (context, index) {
                return index == 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'comments',
                              style: titleb,
                            ),
                          ],
                        ),
                      )
                    : index == (snapshot.data.length + 2) - 1
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Textform(
                              suffix: IconButton(
                                icon: Icon(
                                  Icons.send,
                                  size: 20,
                                  color: maincolor,
                                ),
                                onPressed: AddComment,
                              ),
                              controller: com,
                              obscure: false,
                              text: 'add comment',
                              textInputType: TextInputType.text,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return   ShowEmpProfile(user_id:'${snapshot.data[index-1]['user']['id']}');
                                      },
                                    ));
                                  },
                                  child: ProfileTag(
                                    image: NetworkImage(
                                        '$image_root${snapshot.data[index - 1]['user_profile']['image_url']}'),
                                    name: Text(
                                        '${snapshot.data[index - 1]['user']['name']}'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 55, bottom: 10),
                                  child: Text(
                                    '${snapshot.data[index - 1]['comment']['content']}',
                                    style: greyfont,
                                  ),
                                ),
                              ],
                            ),
                          );
              });
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child:
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Textform(
                    suffix: IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 20,
                        color: maincolor,
                      ),
                      onPressed: AddComment,
                    ),
                    controller: com,
                    obscure: false,
                    text: 'add comment',
                    textInputType: TextInputType.text,
                  ),
                )
              
            
          );
        }
      },
    );
  }
}
