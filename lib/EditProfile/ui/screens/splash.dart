import 'dart:async';
import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/ui/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'edit_profile.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  UserBloc userBloc = UserBloc();

  initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((res) {
      if (res != null)
        checkValidity(res);
      else {
        Timer(
            Duration(seconds: 3),
            () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
                (_) => false));
      }
    });

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.forward();

//    Timer(
//        Duration(seconds: 3),
//        () => Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
//            (_) => false));
  }

  checkValidity(FirebaseUser user) {
    userBloc.checkIfAlreadyExists(user.uid).then((snapshot) {
      if (snapshot.exists) {
//            user signed in and exited
        User user = User.fromJson(snapshot.data);
        if (user.name.isEmpty || user.photoURL.isEmpty) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => EditProfile(true)));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => EditProfile(true)));
      }
    });
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF05C3DD),
                //Colors.deepPurpleAccent,
                const Color(0xFF87189d),
              ],
              //stops: [0.2, 0.7],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: ScaleTransition(
            scale: controller,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: Image(
                  width: 150,
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fiverus2.png?alt=media&token=82091d95-6aa1-41c3-a3cb-f140fbf2d4f3"),
                ),
              )
            ])));
  }
}
