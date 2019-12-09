import 'package:cocreacion/Insta/insta_list.dart';
import 'package:flutter/material.dart';

class InstaBody extends StatelessWidget {
  const InstaBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(child: InstaList(),)
      ],
    );
  }
}