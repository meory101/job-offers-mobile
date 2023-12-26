import 'package:flutter/material.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';

class JobOffer extends StatefulWidget {
 final String location;
  final ImageProvider image;
 final String content;
 final String tag;
  JobOffer(
      {required this.location,
      required this.image,
      required this.content,
       required this.tag});
  @override
  State<JobOffer> createState() => _JobOfferState();
}

class _JobOfferState extends State<JobOffer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: boxcolor,
        borderRadius: BorderRadius.circular(mainborder),
        border: Border.all(color: bordercolor),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mainborder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.location,
                  style: subbfont,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.location_on,
                    color: bordercolor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mainborder),
              image: DecorationImage(
                  image: widget.image, fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10, left: 10, top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mainborder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.content,
                  style: subbfont,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    widget.tag,
                    style: bluefont,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
