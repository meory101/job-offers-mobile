import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kml/components/circular_button.dart';
import 'package:kml/components/comments.dart';
import 'package:kml/components/job_offer.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/db/links.dart';
import 'package:kml/pages/Com_profile.dart';
import 'package:kml/pages/show_emp_profile.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobOfferDet extends StatefulWidget {
  var data;
  JobOfferDet({required this.data});
  @override
  State<JobOfferDet> createState() => _JobOfferDetState();
}

class _JobOfferDetState extends State<JobOfferDet> {
  @override
  void initState() {
    checkType();
    super.initState();
  }

  String? type;
  checkType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString('user_id') != null ? 'user' : 'comp';
    setState(() {
      
    });
    print(type);
  }

  sendcv(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(
        Uri.parse(checkSendCv + '/${prefs.getString('user_id')}' + '/${id}'));
    var body = jsonDecode(response.body);
    if (body['message'] == 'sended') {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'cv is already sended',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      )..show();
    } else {
      var data = {
        'user_id': '${prefs.getString('user_id')}',
        'offer_id': '$id'
      };
      print(data);
      http.Response response = await http.post(Uri.parse(addDeal), body: data);
      var body = jsonDecode(response.body);
      if (body['status'] == 'success') {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'success',
          desc: 'cv is sended',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 10),
                        child: Text(
                          'published by:',
                          style: titleb,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return Comprofile();
                                  },
                                ));
                              },
                              child: ProfileTag(
                                image: NetworkImage(image_root +
                                    "${widget.data['offers']['cprofile']['image_url']}"),
                                name: Text(
                                  "${widget.data['offers']['cprofile']['company']['name']}",
                                  style: subbfont,
                                ),
                              ),
                            ),
                            Text(
                              "${widget.data['offers']['date']}",
                              style: greyfont,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(mainborder),
                    image: DecorationImage(
                      image: NetworkImage(
                          image_root + "${widget.data['offers']['image_url']}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    " ${widget.data['offers']['content']}",
                    style: subbfont,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "#${widget.data['offers']['hashtag']}",
                            style: bluefont,
                          ),
                        ],
                      ),
                   type!=null &&   type == 'user'
                          ? CircularButton(
                              onPressed: () async {
                                await sendcv('${widget.data['offers']['id']}');
                              },
                              icon: Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                            )
                          : Text(''),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: boxcolor,
                      borderRadius: BorderRadius.circular(mainborder),
                      border: Border.all(color: bordercolor),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 0),
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: CommentsSection(
                      offerid: "${widget.data['offers']['id']}",
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
