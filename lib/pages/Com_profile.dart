import 'package:flutter/material.dart';
import 'package:kml/components/Drawer.dart';
import 'package:kml/components/label.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/components/recbutton.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';
 

class Comprofile extends StatefulWidget {
  const Comprofile({super.key});

  @override
  State<Comprofile> createState() => _ComprofileState();
}

class _ComprofileState extends State<Comprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/3.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 50,
                left: MediaQuery.of(context).size.width / 3.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileTag(
                      image: AssetImage("assets/images/2.jpg"),
                      radius: 50,
                      name: Text(
                        '',
                        style: titleb,
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          'MS Programing Company',
                        ))
                  ],
                ),
              ),
              Positioned(
                top: 10,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Drawerwidget();
                  },
                  icon: Icon(
                    Icons.list,
                    color: Colors.white,
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
                          'ًًWork nature ',
                          style: subbfont,
                        ),
                        content: Text(
                          'Full time programing ',
                          style: greyfont,
                        ),
                        icon: Icon(
                          Icons.work,
                          color: maincolor,
                          size: 20,
                        ),
                      ),
                    ),
                    Container(
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
                          'Damascus Almazzeh',
                          style: greyfont,
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(bottom: 14),
                    //   alignment: Alignment.topLeft,
                    //   child: Label(
                    //     icon: Icon(
                    //       Icons.science_rounded,
                    //       color: maincolor,
                    //       size: 20,
                    //     ),
                    //     title: Text(
                    //       'Expert In ',
                    //       style: subbfont,
                    //     ),
                    //     content: Text(
                    //       'Experiences ',
                    //       style: greyfont,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height / 4,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(bottom: 10),
                            margin: EdgeInsets.only(right: 10),
                            height: MediaQuery.of(context).size.height / 4,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: bordercolor),
                              borderRadius: BorderRadius.circular(mainborder),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4 -
                                          40,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(mainborder),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/4.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Text(
                                  'flutter development',
                                  style: subbfont,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 20),
                      alignment: Alignment.topLeft,
                      child: Label(
                          icon: Icon(
                            Icons.book,
                            color: maincolor,
                            size: 20,
                          ),
                          title: Text(
                            'Resume',
                            style: subbfont,
                          ),
                          content: RecButton(
                            label: Text(
                              'open file',
                              style: subwfont,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawerwidget(),
    );
  }
}
