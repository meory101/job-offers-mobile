import 'package:flutter/material.dart';
import 'package:kml/theme/colors.dart';

class CircularButton extends StatefulWidget {
  final Icon icon;
  CircularButton({required this.icon});
  @override
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: maincolor,
      child: Padding(
        padding:  EdgeInsets.only(left: 0),
        child: IconButton(onPressed: () {}, icon: widget.icon),
      ),
    );
  }
}
