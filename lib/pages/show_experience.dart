import 'package:flutter/material.dart';
import 'package:kml/db/links.dart';
import 'package:kml/theme/fonts.dart';

class ShowExp extends StatefulWidget {
  var exp;
  ShowExp({required this.exp});

  @override
  State<ShowExp> createState() => _ShowExpState();
}

class _ShowExpState extends State<ShowExp> {
  int selectedindex = 0;
  bool clickedlike = false;
  @override
  void initState() {
    print(widget.exp);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
           widget.exp ==null?Center(child: CircularProgressIndicator()): Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(right: 10, top: 10),
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image_root+'${widget.exp['image_url']}'),
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
                     '${widget.exp['title']}',
                    style: lmain,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${widget.exp['content']}',
                    style: greyfont,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${widget.exp['years']}',
                    style: submain,
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
