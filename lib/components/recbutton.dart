import 'package:flutter/material.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
  

class RecButton extends StatefulWidget {
final  Widget label;
RecButton({required this.label});
  @override
  State<RecButton> createState() => _RecButtonState();
}

class _RecButtonState extends State<RecButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: maincolor,
        borderRadius: BorderRadius.circular(subborder),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child:widget.label
          )
        ],
      ),
    );
  }
}
