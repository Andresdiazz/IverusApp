
import 'package:cocreacion/insta_trivia/insta_video.dart';
import 'package:flutter/material.dart';

class InstaBody_trivia extends StatelessWidget {
  const InstaBody_trivia({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(child: InstaList_trivia(),)
      ],
    );
  }
}