import 'dart:async';

import 'package:flutter/material.dart';

import 'edit_profile.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FadeIn();
}

class FadeIn extends State<SplashScreen> with TickerProviderStateMixin {
  var animationController;
  @override
  initState() {
    super.initState();

    animationController = AnimationController(
        duration: new Duration(milliseconds: 700), vsync: this);

    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => EditProfile()),
            (_) => false));
  }

  Timer _timer;
  FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;

//  FadeIn() {
//    _timer = new Timer(const Duration(seconds: 2), () {
//      setState(() {
//        _logoStyle = FlutterLogoStyle.horizontal;
//      });
//    });
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizeTransition(
          sizeFactor: new CurvedAnimation(
              parent: animationController, curve: Curves.linearToEaseOut),
          axisAlignment: 0,
          child: Image(
            image: AssetImage("assets/img/excited.png"),
          )),
    );
  }
}
