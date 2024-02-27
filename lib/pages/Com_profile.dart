import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kml/components/drawer.dart';
import 'package:kml/components/label.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/db/links.dart';
import 'package:kml/db/post_with_file.dart';
import 'package:kml/pages/Login.dart';
import 'package:kml/pages/create_job_opportunity.dart';
import 'package:kml/pages/edit_Cprofile_info.dart';
import 'package:kml/pages/edit_job_opportunity.dart';
import 'package:kml/pages/edit_Uprofile_info.dart';
import 'package:kml/pages/show_job_opportunity.dart';
import 'package:kml/pages/show_map.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comprofile extends StatefulWidget {
  const Comprofile({super.key});

  @override
  State<Comprofile> createState() => _ComprofileState();
}

class _ComprofileState extends State<Comprofile> {
  GlobalKey<ScaffoldState> skey = new GlobalKey();
  var profile_info;
  var offer;

  GetComProfile() async {
    print('hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(comprofile + '/${prefs.getString('com_id')}');
    http.Response response = await http.get(
      Uri.parse(comprofile + '/${prefs.getString('com_id')}'),
    );
    print('/${prefs.getString('com_id')}');
    var body = jsonDecode(response.body);
    if (body['status'] == 'success') {
      profile_info = body['message'];
      print(profile_info);
      prefs.setString('profile_id', '${profile_info['id']}');
      print(prefs.getString('com_id'));
      GetComoffer();
      setState(() {});
    }
  }

  GetComoffer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(
      Uri.parse(getOffer + '/${prefs.getString('profile_id')}'),
    );
    var body = jsonDecode(response.body);
    print(body);
    if (body['status'] == 'success') {
      body = body['message'];
      return body;
    }
    return null;
  }

  Deleteoffer(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(id);
    http.Response response =
        await http.post(Uri.parse(deletoffer), body: {'id': '${id}'});
    var body = jsonDecode(response.body);
    print(body);
    if (body['status'] == 'success') {
      GetComoffer();
    }
    setState(() {});
  }

  @override
  void initState() {
    GetComProfile();
    super.initState();
  }

  UpdateComProfile(files, names) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = {'id': '${prefs.getString('profile_id')}'};
    var body = await postWithMultiFile(update_com_profile, data, files, names);
    if (body['status'] == 'success') {
      GetComProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: skey,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.6,
        child: Drawerwidget([
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: maincolor),
              accountName: profile_info == null
                  ? CircularProgressIndicator()
                  : Text(
                      "${profile_info['company']['name']}",
                      style: titlew,
                    ),
              // accountName: Text(
              //   "${profile_info['comdata']['name']}",
              //    style: titlew,
              // ),
              accountEmail: Text("company account", style: subwfont),
              currentAccountPicture: profile_info == null
                  ? CircularProgressIndicator()
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                          image_root + "${profile_info['image_url']}"),
                    ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return CProfileInfo(
                    work: profile_info['work_type'],
                    lat: '${profile_info['lat']}',
                    long: '${profile_info['long']}',
                  );
                },
              ));
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.person,
                color: maincolor,
                size: 20,
              ),
              title: Text(
                "Edit profile Info",
                style: subbfont,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Create_new();
                  },
                ),
              );
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.bookmark,
                color: maincolor,
                size: 20,
              ),
              title: Text(
                'New job offer',
                style: subbfont,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Loginpage()),
                  (route) => false);
            },
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: maincolor,
                size: 20,
              ),
              title: Text(
                "Logout",
                style: subbfont,
              ),
            ),
          ),
        ]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              InkWell(
                onTap: () async {
                  var res = await ImagePicker.platform
                      .getImageFromSource(source: ImageSource.gallery);
                  if (res != null) {
                    UpdateComProfile([File(res.path)], ['cover']);
                  }
                },
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
                      onTap: () async {
                        var res = await ImagePicker.platform
                            .getImageFromSource(source: ImageSource.gallery);
                        if (res != null) {
                          UpdateComProfile([File(res.path)], ['image']);
                        }
                      },
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
                    profile_info == null
                        ? CircularProgressIndicator()
                        : Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              '${profile_info['company']['name']}',
                              style: titlew,
                            ))
                  ],
                ),
              ),
              Positioned(
                top: 10,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    skey.currentState!.openDrawer();
                  },
                  icon: Image.asset(
                    'assets/images/bars-sort.png',
                    width: 15,
                    height: 20,
                  ),
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
                          'ًًWork Type ',
                          style: subbfont,
                        ),
                        content: profile_info == null
                            ? CircularProgressIndicator()
                            : Text(
                                '${profile_info['work_type']}',
                                style: greyfont,
                              ),
                        icon: Icon(
                          Icons.work,
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
                            Icons.location_on,
                            color: maincolor,
                            size: 20,
                          ),
                          title: Text(
                            'Location',
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
                      margin: EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      child: FutureBuilder(
                        future: GetComoffer(),
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
                                      FocusedMenuItem(
                                          title: Text("create new"),
                                          trailingIcon: Icon(
                                            Icons.create_new_folder,
                                            color: maincolor,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return Create_new();
                                                },
                                              ),
                                            );
                                          }),
                                      FocusedMenuItem(
                                          title: Text("Edit"),
                                          trailingIcon: Icon(
                                            Icons.edit,
                                            color: maincolor,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return EditJobOpp(
                                                      offer:
                                                          snapshot.data[index]);
                                                },
                                              ),
                                            );
                                          }),
                                      FocusedMenuItem(
                                          title: Text("Delete"),
                                          trailingIcon: Icon(
                                            Icons.delete,
                                            color: maincolor,
                                          ),
                                          onPressed: () async {
                                            await Deleteoffer(
                                                snapshot.data[index]['id']);
                                          })
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
                              'you didn\'t upload any offers yet',
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
      // drawer: Drawerwidget(),
    );
  }
}
