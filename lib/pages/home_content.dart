import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kml/components/filter.dart';
import 'package:kml/components/job_offer.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/components/search.dart';
import 'package:kml/db/links.dart';
import 'package:kml/pages/com_profile.dart';
import 'package:kml/pages/job_offer.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

var profile_info;
String? user_id;
String? com_id;

class _HomeContentState extends State<HomeContent> {
  GetProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = await prefs.getString('user_id');
    com_id = await prefs.getString('com_id');
    String url = user_id != null
        ? userprofile + '/${user_id}'
        : comprofile + '/${com_id}';

    http.Response response = await http.get(Uri.parse(url));

    var body = jsonDecode(response.body);
    if (body['status'] == 'success') {
      profile_info = body['message'];

      setState(() {});
    }
  }

  GetOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = getoffers;

    http.Response response = await http.get(Uri.parse(url));

    var body = jsonDecode(response.body);
    print(body);
    if (body['status'] == 'success') {
      return body['message'];
    }
    return null;
  }

  @override
  void initState() {
    GetProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              profile_info == null
                  ? Container(
                      margin: EdgeInsets.only(top: 30),
                      child: ProfileTag(
                        image: AssetImage('assets/images/user.png'),
                        name: profile_info != null
                            ? Text(
                                user_id != null
                                    ? " ${profile_info['user']['name']}"
                                    : " ${profile_info['company']['name']}",
                                style: titleb,
                              )
                            : Text(''),
                        radius: 30,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 30),
                      child: ProfileTag(
                        image: NetworkImage(
                            image_root + '${profile_info['image_url']}'),
                        name: Text(
                          user_id != null
                              ? " ${profile_info['user']['name']}"
                              : " ${profile_info['company']['name']}",
                          style: titleb,
                        ),
                        radius: 30,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 9),
                child: Text(
                  user_id == null ? 'company account' : 'user account',
                  style: subbfont,
                ),
              )
            ],
          ),
          Search(),
          Filter(),
          Container(
            alignment: Alignment.topLeft,
            height: MediaQuery.of(context).size.height / 1.5,
            child: FutureBuilder(
              future: GetOffers(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return JobOfferDet(
                                    data: snapshot.data[index],
                                  );
                                },
                              ));
                            },
                            child: JobOffer(
                              location:
                                  "${snapshot.data[index]['offers']['cprofile']['location']}",
                              image: NetworkImage(
                                image_root +
                                    "${snapshot.data[index]['offers']['image_url']}",
                              ),
                              content:
                                  "${snapshot.data[index]['offers']['content']}",
                              tag:
                                  "#${snapshot.data[index]['offers']['hashtag']}",
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return Comprofile();
                                      },
                                    ));
                                  },
                                  child: ProfileTag(
                                    image: NetworkImage(
                                      image_root +
                                          "${snapshot.data[index]['offers']['cprofile']['image_url']}",
                                    ),
                                    name: Text(
                                      " ${snapshot.data[index]['offers']['cprofile']['company']['name']}",
                                      style: subbfont,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${snapshot.data[index]['offers']['date']}",
                                  style: greyfont,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Text(
                      'No offers',
                      style: greyfont,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
