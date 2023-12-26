import 'package:flutter/material.dart';
 
class Label extends StatefulWidget {
  Text title;
  Widget content;
  Icon icon;
  Label({required this.title, required this.content,required this.icon});

  @override
  State<Label> createState() => _LabelState();
}

class _LabelState extends State<Label> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.title,
                widget.content,
              ],
            ),
          ),
         Expanded(
          flex: 1,
          child: widget.icon)
        ],
      ),
    );
  }
}
