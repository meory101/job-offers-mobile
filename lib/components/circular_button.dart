import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kml/theme/colors.dart';

class CircularButton extends StatefulWidget {
  final Icon icon;
  Color ?color;
   void Function()? onPressed;
  CircularButton({required this.icon,this.color,this.onPressed});
  @override
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        backgroundColor: widget.color == null ? maincolor : widget.color,
        child: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(onPressed: widget.onPressed, icon: widget.icon),
        ),
      ),
    );
  }
}
