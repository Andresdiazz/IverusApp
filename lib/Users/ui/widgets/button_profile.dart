import 'package:cocreacion/EditProfile/ui/screens/edit_profile.dart';
import 'package:cocreacion/EditProfile/ui/screens/splash.dart';
import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:cocreacion/Users/bloc/home_bloc.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ButtonProfile extends StatelessWidget {
  double fontSize;
  double width;
  double height;

  User user;

  HomeBloc homeBloc;

  ButtonProfile(
      {@required this.homeBloc,
      this.user,
      this.fontSize,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: StreamBuilder(
        stream: homeBloc.user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return profile(context);
          } else {
            return showProfileData(snapshot, context);
          }

          /*  switch (snapshot.connectionState) {
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
            }*/
        },
      ),
    );
  }

  Widget profile(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: width,
      //40.0,
      height: height,
      //40.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fprofile_final.jpg?alt=media&token=1ab94d3e-5a19-4cf2-ba7c-b973f8bfdf4c"))),
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot, BuildContext context) {
    user = snapshot.data;

    final userName = Container(
        margin: EdgeInsets.only(left: 40.0, top: 10.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(

            ),
            child: Text(
              user.name == null ? "" : user.name ,
              //"Andres Diaz",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontFamily: "Aileron",
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                inherit: true,

              ),

            ),
          )
        ));

    final photo = Container(
      margin: EdgeInsets.only(top: 20),
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: user.photoURL == null
                  ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fprofile_final.jpg?alt=media&token=1ab94d3e-5a19-4cf2-ba7c-b973f8bfdf4c")
                  : NetworkImage(user.photoURL))),
    );

    var updatedPhoto = Container(
      margin: const EdgeInsets.only(top: 20),
      height: height,
      width: width,
      child: CircularPercentIndicator(
        animation: true,
        radius: width / 1.15,
        lineWidth: width / 20,
        percent: getPercent(user.points == null ? 0 : user.points),
        //progressColor: Colors.amber,
        linearGradient: LinearGradient(
            colors: [
              //const Color(0xFF05C3DD),
              Colors.deepPurpleAccent,
              //const Color(0xFF87189d),
              Colors.amberAccent
            ],
            //stops: [0.2, 0.7],
            //begin: Alignment.topRight,
            //end: Alignment.bottomLeft,
        ),
        center: Container(
          width: width / 1.3,
          height: width / 1.3,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: user.photoURL == null
                      ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fprofile_final.jpg?alt=media&token=1ab94d3e-5a19-4cf2-ba7c-b973f8bfdf4c")
                      : NetworkImage(user.photoURL))),
        ),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          child: updatedPhoto,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfile(false)));
          },
        ),
        Center(
          child: userName,
        )
      ],
    );
  }

  getPercent(int points) {
    if (points <= 100) {
      return 0.33;
    } else if (points > 100 && points <= 200) {
      return 0.66;
    } else if (points > 200) {
      return 1.0;
    }
  }
}
