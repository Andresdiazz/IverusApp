import 'package:cocreacion/Insta/insta_list.dart';
import 'package:cocreacion/insta_video/insta_video.dart';
import 'package:flutter/material.dart';

class InstaBody_video extends StatelessWidget {
  const InstaBody_video({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(child: InstaList_video(),)
      ],
    );
  }
}