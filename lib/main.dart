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
            home: SplashScreen()),
        bloc: UserBloc());
  }
}
