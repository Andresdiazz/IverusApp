import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/ui/screens/profile_header.dart';
import 'package:cocreacion/Users/ui/widgets/background_profile.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:cocreacion/Ideas/ui/screens/home.dart';

import 'cards_profile.dart';
import 'login_screen.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

class ProfileScreen extends StatelessWidget {
  User user;

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    Future<void> _neverSatisfied() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¿Estás seguro de cerrar sesión?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Para subir una idea tienes que volver a iniciar sesión'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar')),
              FlatButton(
                child: Text('Cerrar sesión'),
                onPressed: () {
                  userBloc.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 0, right: 32),
              child: InkWell(
                onTap: () {
                  _neverSatisfied();
                  //userBloc.signOut();
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                },
                child: Icon(
                  Icons.exit_to_app,
                  size: 30.0,
                  color: Colors.white,
                ),
              )),
          //BarScore()
        ],
      ),
    );
  }
}
