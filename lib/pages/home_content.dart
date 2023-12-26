import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kml/components/filter.dart';
import 'package:kml/components/job_offer.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/components/search.dart';
import 'package:kml/pages/com_profile.dart';
import 'package:kml/pages/job_offer.dart';
import 'package:kml/theme/fonts.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                child: ProfileTag(
                  image: AssetImage("assets/images/man.jpg"),
                  name: Text(
                    " Bill mark",
                    style: titleb,
                  ),
                  radius: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 9),
                child: Text(
                  'company account',
                  style: subbfont,
                ),
              )
            ],
          ),
          Search(),
          Filter(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return JobOfferDet();
                },
              ));
            },
            child: JobOffer(
              location: "Damascus Syria",
              image: AssetImage('assets/images/g1.jpg'),
              content:
                  "Select your level from A1 English level to C1 English level Reading practice to help you understand long, complex texts about a wide variety.",
              tag: "#Jobname",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
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
          JobOffer(
            location: "London UK",
            image: AssetImage('assets/images/g2.jpg'),
            content:
                "Select your level from A1 English level to C1 English level Reading practice to help you understand long, complex texts about a wide variety.",
            tag: "#Jobname",
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileTag(
                  image: AssetImage("assets/images/g1.jpg"),
                  name: Text(
                    " Company name",
                    style: subbfont,
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
    );
  }
}
