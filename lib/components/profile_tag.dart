import 'package:flutter/material.dart';
import 'package:kml/theme/colors.dart';

class ProfileTag extends StatefulWidget {
 final ImageProvider image;
 final Widget name;
 final double? radius;
  ProfileTag({required this.image, required this.name, this.radius});
  @override
  State<ProfileTag> createState() => _ProfileTagState();
}

class _ProfileTagState extends State<ProfileTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 0),
      child: Row(
        children: [
          CircleAvatar(
            radius: widget.radius!=null?widget.radius:20,
            foregroundColor: bordercolor,
            backgroundColor: bordercolor,
            backgroundImage: widget.image,
            
          ),
          Padding(padding: EdgeInsets.only(left: 9),child: widget.name,)
        ],
      ),
    );
  }
}
