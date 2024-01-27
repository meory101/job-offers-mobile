import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kml/components/filter.dart';
import 'package:kml/components/job_offer.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/components/search.dart';
import 'package:kml/db/links.dart';
import 'package:kml/pages/Com_profile.dart';
import 'package:kml/pages/emp_profile.dart';
import 'package:kml/pages/home_content.dart';
import 'package:kml/pages/inbox.dart';
import 'package:kml/pages/job_offer.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';

class Home extends StatefulWidget {
  String? type;
  Home({required this.type});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(subborder)),
          height: 60,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: BottomAppBar(
            child: FlashyTabBar(
              selectedIndex: _selectedIndex,
              showElevation: true,
              onItemSelected: (index) => setState(() {
                _selectedIndex = index;
              }),
              items: [
                FlashyTabBarItem(
                  icon: Icon(
                    CupertinoIcons.person,
                    color: maincolor,
                  ),
                  title: Text(
                    'Profile',
                    style: submain,
                  ),
                ),
                FlashyTabBarItem(
                  icon: Icon(
                    CupertinoIcons.cube_box,
                    color: maincolor,
                  ),
                  title: Text('Home', style: submain),
                ),
                FlashyTabBarItem(
                  icon: Icon(
                    CupertinoIcons.mail,
                    color: maincolor,
                  ),
                  title: Text('Inbox', style: submain),
                ),
              ],
            ),
          ),
        ),
        body: _selectedIndex == 1
            ? HomeContent()
            : _selectedIndex == 0 ? widget.type == "user"?
                 EmpProfile()
                 :Comprofile()
                : Inbox(),
      ),
    );
  }
}
