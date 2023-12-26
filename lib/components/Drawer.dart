import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kml/theme/colors.dart';

class Drawerwidget extends StatelessWidget {
  List<Widget> items;
  Drawerwidget( this.items);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        children: items
      ),
    );
  }
}
