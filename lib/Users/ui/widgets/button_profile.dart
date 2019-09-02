
import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';


class ButtonProfile extends StatelessWidget {

  double fontSize;
  double width;
  double height;

  User user;

  UserBloc userBloc;

  ButtonProfile({@required this.userBloc, this.user, this.fontSize, this.height, this.width});

  @override
  Widget build(BuildContext context) {

      userBloc = BlocProvider.of<UserBloc>(context);

      return StreamBuilder(
        stream: userBloc.streamFirebase,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.active:
            // TODO: Handle this case.
              return showProfileData(snapshot, context);
            case ConnectionState.done:
            // TODO: Handle this case.
              return showProfileData(snapshot, context);
            case ConnectionState.waiting:
            // TODO: Handle this case.
              return //CircularProgressIndicator();
                profile(context);
            case ConnectionState.none:
            // TODO: Handle this case.
              return profile(context);
            default:
              return showProfileData(snapshot, context);
          }
        },
      );

    }

  Widget profile(BuildContext context){
    final photo = Container(
      margin: EdgeInsets.only(
          top: 30.0,
          right: 10.0
      ),

      width: width,
      //40.0,
      height: height,
    //40.0,

      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/img/profile.jpg")
          )
      ),
    );

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
        return BlocProvider<UserBloc>(
          bloc: UserBloc(),
          child: ProfileScreen(),
        );

      },
      child: photo,
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot, BuildContext context) {
    user = User(
        name: snapshot.data.displayName,
        photoURL: snapshot.data.photoUrl,
        email: snapshot.data.email
    );

    final userName = Container(
      margin: EdgeInsets.only(
          left: 40.0,
          top:10.0
      ),

      child: Center(
        child: Text(
          user.name,
          //"Andres Diaz",
          textAlign: TextAlign.end,
          style: TextStyle(
              fontFamily: "Lato",
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              color: Colors.white
          ),
        ),
      )
    );

    final photo = Container(
      margin: EdgeInsets.only(top: 20),


      width: width,
      height: height,

      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: //AssetImage("assets/img/profile.jpg")
              NetworkImage(user.photoURL)
          )
      ),
    );

    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          photo,
          Center(
            child: userName,
          )
        ],
      );

  }

  }









