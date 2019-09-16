import 'dart:async';
import 'package:cocreacion/Users/ui/screens/login_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.forward();

    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
            (_) => false));
  }

  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        child: ScaleTransition(
            scale: controller,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: Image(
                  width: 150,
                  image: AssetImage("assets/img/iverus2.png"),
                ),
              )
            ])));
  }
}
