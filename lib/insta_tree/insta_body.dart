
import 'package:cocreacion/insta_tree/insta_video.dart';
import 'package:cocreacion/insta_trivia/insta_video.dart';
import 'package:flutter/material.dart';

class InstaBody_tree extends StatelessWidget {
  const InstaBody_tree({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(child: InstaList_tree(),)
      ],
    );
  }
}