import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TextBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 70.0,
      //width: 400.0,
      margin: EdgeInsets.only(left: 10.0),
      child: ColorizeAnimatedTextKit(
        onTap: () {
          print("Tap Event");
        },
        text: [
          "IVERUS",
        ],
        textStyle: TextStyle(
            fontSize: 30.0, fontFamily: "Aileron", letterSpacing: 2.0),
        colors: [
          Colors.white,
          Colors.white,
          Colors.white,
        ],

        textAlign: TextAlign.end,
        alignment: AlignmentDirectional.bottomStart,
        duration: Duration(seconds: 5),
        // or Alignment.topLeft
      ),
    );
  }
}
