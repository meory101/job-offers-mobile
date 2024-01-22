import 'package:flutter/material.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';

class RecButton extends StatefulWidget {
  final Widget label;
  final double width;
  final double height;
  final color;
  void Function()? fun;

  RecButton(
      {required this.label,
      required this.width,
      required this.height,
      required this.color,
      this.fun});
  @override
  State<RecButton> createState() => _RecButtonState();
}

class _RecButtonState extends State<RecButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.fun,
      child: Container(
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          border: Border.all(color: maincolor),
          color: widget.color,
          borderRadius: BorderRadius.circular(subborder),
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [widget.label],
        ),
      ),
    );
  }
}
