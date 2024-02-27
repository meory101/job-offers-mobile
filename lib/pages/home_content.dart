import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kml/components/filter.dart';
import 'package:kml/components/job_offer.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/components/search.dart';
import 'package:kml/db/links.dart';
import 'package:kml/pages/com_profile.dart';
import 'package:kml/pages/job_offer.dart';
import 'package:kml/pages/show_com_profile.dart';
import 'package:kml/pages/map.dart';
import 'package:kml/pages/show_map.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
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
String? latlong;
String? com_id;
bool se = false;
TextEditingController searchcon = new TextEditingController();
var data = [];
var offers;
bool filter = false;

class _HomeContentState extends State<HomeContent> {
  FilterData() async {
    setState(() {
      filter = true;
    });
    data = [];
    if (latlong != null) {
      print('latttttttttttttt');
      double lat = double.parse('${latlong!.split('*')[0]}');
      double long = double.parse('${latlong!.split('*')[1]}');
      if (search_res != null) {
        for (int i = 0; i < search_res.length; i++) {
          if (Geolocator.distanceBetween(
                      lat,
                      long,
                      double.parse(search_res[i]['offers']['cprofile']['lat']),
                      double.parse(
                          search_res[i]['offers']['cprofile']['long'])) /
                  1000.0 <=50
              ) {
            data.add(search_res[i]);
            ;
          }
        }
      } else {
        print('else');
        for (int i = 0; i < offers.length; i++) {
          if (Geolocator.distanceBetween(
                      lat,
                      long,
                      double.parse(offers[i]['offers']['cprofile']['lat']),
                      double.parse(offers[i]['offers']['cprofile']['long'])) /
                  1000.0 <=
              50) {
            data.add(offers[i]);
          }
        }
      }
    }
    return data;
  }

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

  var search_res;
  SearchOffers() async {
    if (searchcon.text.isNotEmpty) {
      print('ddddddddddddd');
      http.Response response =
          await http.get(Uri.parse(search_offer + '/${searchcon.text}'));
      print(search_offer + '/${searchcon.text}');
      var body = jsonDecode(response.body);
      if (body['status'] == 'success') {
        // setState(() {
        search_res = body['message'];
        // });
        return body['message'];
      }
      return null;
    } else {
      setState(() {
        se = false;
      });
    }
    // searchcon.clear();
  }

  GetOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = getoffers;

    http.Response response = await http.get(Uri.parse(url));

    var body = jsonDecode(response.body);
    print(body);
    if (body['status'] == 'success') {
      offers = body['message'];
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
          Container(
            alignment: Alignment.center,
            width: double.infinity - 40,
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(mainborder),
                color: palemain),
            child: TextFormField(
              controller: searchcon,
              style: subbfont,
              cursorColor: maincolor,
              decoration: InputDecoration(
                hintText: " Search",
                hintStyle: subbfont,
                suffixIcon: IconButton(
                  onPressed: () {
                    se = true;
                    SearchOffers();
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.search,
                    color: maincolor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity - 40,
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(mainborder),
                color: palemain),
            child: InkWell(
              onTap: () async {
                latlong = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Map();
                  },
                ));
                print(latlong);
                FilterData();
              },
              child: TextFormField(
                enabled: false,
                style: subbfont,
                cursorColor: maincolor,
                decoration: InputDecoration(
                  hintText: " Filter by",
                  hintStyle: subbfont,
                  suffixIcon: IconButton(
                    onPressed: () async {},
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: maincolor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            height: MediaQuery.of(context).size.height / 1.5,
            child: FutureBuilder(
              future: filter
                  ? FilterData()
                  : se
                      ? SearchOffers()
                      : GetOffers(),
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
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return showMap(
                                        lat:
                                            "${snapshot.data[index]['offers']['cprofile']['lat']}",
                                        long:
                                            "${snapshot.data[index]['offers']['cprofile']['long']}");
                                  },
                                ));
                              },
                              location: "Location",
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
                                        return ShowComProfile(
                                          profile_id:
                                              "${snapshot.data[index]['offers']['cprofile']['id']}",
                                          com_id:
                                              "${snapshot.data[index]['offers']['cprofile']['company_id']}",
                                        );
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
