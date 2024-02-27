import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kml/components/drawer.dart';
import 'package:kml/components/circular_button.dart';
import 'package:kml/components/label.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/components/rectangular_button.dart';
import 'package:kml/db/links.dart';
import 'package:kml/pages/edit_Uprofile_info.dart';
import 'package:kml/pages/show_experience.dart';
import 'package:kml/pages/show_job_opportunity.dart';
import 'package:kml/pages/show_map.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShowComProfile extends StatefulWidget {
  String com_id;
  String profile_id;
  ShowComProfile({required this.com_id, required this.profile_id});
  @override
  State<ShowComProfile> createState() => _ShowComProfileState();
}

class _ShowComProfileState extends State<ShowComProfile> {
  var profile_info;
  GetProfile() async {
    print('laaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print(comprofile + '/${widget.com_id}');
    http.Response response = await http.get(
      Uri.parse(comprofile + '/${widget.com_id}'),
    );

    var body = jsonDecode(response.body);
    if (body['status'] == 'success') {
      profile_info = body['message'];
      GetOffers();
      setState(() {});
    }
  }

  GetOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(
      Uri.parse(getOffer + '/${widget.profile_id}'),
    );
    var body = jsonDecode(response.body);
    print(body);
    if (body['status'] == 'success') {
      body = body['message'];
      return body;
    }
    return null;
  }

  @override
  void initState() {
    print(getcoffers + '${widget.profile_id}');

    GetProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              InkWell(
                child: profile_info == null
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/t.jpg"),
                              fit: BoxFit.cover),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  image_root + '${profile_info['cover_url']}'),
                              fit: BoxFit.cover),
                        ),
                      ),
              ),
              Positioned(
                top: 50,
                left: MediaQuery.of(context).size.width / 3.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: profile_info == null
                          ? ProfileTag(
                              image: AssetImage("assets/images/user.png"),
                              radius: 50,
                              name: Text(
                                '',
                                style: titleb,
                              ),
                            )
                          : ProfileTag(
                              image: NetworkImage(
                                  image_root + '${profile_info['image_url']}'),
                              radius: 50,
                              name: Text(
                                '',
                                style: titleb,
                              ),
                            ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: profile_info == null
                          ? CircularProgressIndicator()
                          : Text(
                              "${profile_info['company']['name']}",
                              style: titlew,
                            ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 200,
                margin: EdgeInsets.only(
                  top: 200,
                  bottom: 14,
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(mainborder),
                    topRight: Radius.circular(mainborder),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 14),
                      alignment: Alignment.topLeft,
                      child: Label(
                        title: Text(
                          'Worked type ',
                          style: subbfont,
                        ),
                        content: profile_info == null
                            ? CircularProgressIndicator()
                            : Text(
                                '${profile_info['work_type']}',
                                style: greyfont,
                              ),
                        icon: Icon(
                          Icons.school_outlined,
                          color: maincolor,
                          size: 20,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return showMap(
                                lat: profile_info['lat'],
                                long: profile_info['long'],
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 14),
                        alignment: Alignment.topLeft,
                        child: Label(
                          icon: Icon(
                            Icons.work_outline,
                            color: maincolor,
                            size: 20,
                          ),
                          title: Text(
                            'location ',
                            style: subbfont,
                          ),
                          content: Text(
                            'click here',
                            style: greyfont,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 14),
                      alignment: Alignment.topLeft,
                      child: Label(
                        icon: Icon(
                          Icons.science_outlined,
                          color: maincolor,
                          size: 20,
                        ),
                        title: Text(
                          'offers ',
                          style: subbfont,
                        ),
                        content: Text(
                          'offers here ',
                          style: greyfont,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      child: FutureBuilder(
                        future: GetOffers(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return FocusedMenuHolder(
                                    onPressed: () {},
                                    menuItems: <FocusedMenuItem>[
                                      FocusedMenuItem(
                                          title: Text("show"),
                                          trailingIcon: Icon(
                                            Icons.play_circle_fill_rounded,
                                            color: maincolor,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ShowOpp(
                                                      offer:
                                                          snapshot.data[index]);
                                                },
                                              ),
                                            );
                                          }),
                                    ],
                                    child: Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        margin: EdgeInsets.only(right: 10),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: bordercolor),
                                          borderRadius:
                                              BorderRadius.circular(mainborder),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      3 -
                                                  40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          mainborder),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      image_root +
                                                          '${snapshot.data[index]['image_url']}',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            Text(
                                              '${snapshot.data[index]['hashtag']}',
                                              style: subbfont,
                                            )
                                          ],
                                        )));
                              },
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Center(
                                child: Text(
                              'no offers yet',
                              style: greyfont,
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
