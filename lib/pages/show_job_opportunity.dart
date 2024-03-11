import 'package:flutter/material.dart';
import 'package:kml/db/links.dart';
import 'package:kml/theme/fonts.dart';

class ShowOpp extends StatefulWidget {
  var offer;
  ShowOpp({required this.offer});

  @override
  State<ShowOpp> createState() => _ShowOppState();
}

class _ShowOppState extends State<ShowOpp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            widget.offer == null
                ? CircularProgressIndicator()
                : Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(right: 10, top: 10),
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              image_root + '${widget.offer['image_url']}'),
                          fit: BoxFit.cover),
                    ),
                  ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              width: double.infinity,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.5 - 30,
                  left: 3,
                  right: 3),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.4)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '${widget.offer['content']}',
                    style: greyfont,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        '#${widget.offer['hashtag']}',
                        style: submain,
                      ),
                      
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
