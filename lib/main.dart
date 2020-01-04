import 'package:cocreacion/PageVideoView.dart';
import 'package:cocreacion/PageView.dart';
import 'package:cocreacion/insta_tree/insta_home.dart';
import 'package:cocreacion/insta_trivia/insta_home.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter/material.dart';

import 'EditProfile/ui/screens/splash.dart';
import 'Users/bloc/bloc_user.dart';
import 'live_videos/live_videos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,

            title: 'IverusApp',
//            home: SplashScreen()),
            home: SplashScreen(),
          routes: <String, WidgetBuilder> {
            '/HomeView' : (BuildContext context) => new HomeView(),
            '/VideoApp' :( BuildContext context) => new VideoApp(),
            '/InstHome_trivia' :( BuildContext context) => new InstHome_trivia(),
            '/InstHome_tree' :( BuildContext context) => new InstHome_tree(),


          },
        ),

        bloc: UserBloc(),
    );
  }
}
