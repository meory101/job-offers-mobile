import 'package:flutter/material.dart';
import 'package:kml/components/profile_tag.dart';
import 'package:kml/theme/fonts.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({super.key});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return index == 0
            ? Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Text(
                  'comments',
                  style: titleb,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileTag(
                        image: AssetImage("assets/images/g2.jpg"),
                        name: Text('user name')),
                    Padding(
                      padding: const EdgeInsets.only(left: 55, bottom: 10),
                      child: Text(
                        'comment something about job offer and this is how the comment is!',
                        style: greyfont,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
