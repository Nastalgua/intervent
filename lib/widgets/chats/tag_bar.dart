import 'package:flutter/material.dart';
import 'package:intervent/constants/tags.dart';
import 'package:intervent/widgets/chats/tag_item.dart';

class TagBar extends StatelessWidget {
  const TagBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: new List.generate(Tags.length, (index) {
            return new TagItem(name: Tags[index]);
          }
        ),
      ),
    );
  }
}