import 'package:cocreacion/authphone.dart';
import 'package:cocreacion/example.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter/material.dart';


import 'Users/bloc/bloc_user.dart';
import 'Users/ui/screens/login_screen.dart';
import 'Users/ui/screens/phone_login_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: MaterialApp(
            title: 'Flutter Demo',
            home: LoginScreen()
        ),
        bloc: UserBloc()
    );
  }
}
