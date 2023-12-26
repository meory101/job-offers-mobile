import 'package:flutter/material.dart';
import 'package:kml/components/circular_button.dart';
import 'package:kml/components/comments.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/pages/Com_profile.dart';
import 'package:kml/pages/show_emp_profile.dart';
import 'package:kml/theme/borders.dart';
import 'package:kml/theme/colors.dart';
import 'package:kml/theme/fonts.dart';

class JobOfferDet extends StatefulWidget {
  const JobOfferDet({super.key});

  @override
  State<JobOfferDet> createState() => _JobOfferDetState();
}

class _JobOfferDetState extends State<JobOfferDet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 10),
                        child: Text(
                          'published by:',
                          style: titleb,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return Comprofile();
                                  },
                                ));
                              },
                              child: ProfileTag(
                                image: AssetImage("assets/images/g1.jpg"),
                                name: Text(
                                  " Company name",
                                  style: subbfont,
                                ),
                              ),
                            ),
                            Text(
                              "5 June 2020",
                              style: greyfont,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(mainborder),
                    image: DecorationImage(
                      image: AssetImage("assets/images/g2.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Select your level from A1 English level to C1 English level Reading practice to help you understand long, complex texts about a wide variety.",
                    style: subbfont,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#Jobname",
                        style: bluefont,
                      ),
                      CircularButton(
                        icon: Icon(Icons.send_rounded,color: Colors.white,),
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: boxcolor,
                      borderRadius: BorderRadius.circular(mainborder),
                      border: Border.all(color: bordercolor),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 0),
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: CommentsSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
