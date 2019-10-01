import 'package:cocreacion/Ideas/ui/screens/home.dart';
import 'package:cocreacion/Ideas/ui/widgets/ideas_user_info.dart';
import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileHeader extends StatelessWidget {

  User user;

  UserBloc userBloc;

  ProfileHeader({@required this.user, this.userBloc});

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
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/img/profile_final.jpg")
          )
      ),
    );

    final nameUser = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Name",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
                fontFamily: "Niagara"
            ),
          ),
        ),
        Text(
          "Desciption",
          style: TextStyle(
              fontSize: 15.0
          ),
        )
      ],
    );

    final text = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 80.0),
          child: InkWell(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context)=> IdeasUserInfo(user)))
            ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Text("My Ideas")
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("10"),
                    Icon(Icons.favorite, color: Colors.redAccent,)
                  ],
                )
              ],
            ),
          ),
          
        ),
        Container(
            margin: EdgeInsets.only(left: 120.0),
            child: InkWell(
              onTap: (){

              },
              child: Text("Editar",
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
            )
        )
      ],
    );


    return Container(
      margin: EdgeInsets.only(top: 120.0, left: 10.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          photo,
          nameUser,
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: text,
          )
        ],

      ),
    );
}


  Widget showProfileData(AsyncSnapshot snapshot, BuildContext context){
    if(!snapshot.hasData || snapshot.hasError){
      print("No logueado");
      return Container(
        margin: EdgeInsets.only(top: 120.0, left: 10.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("No se pudo cargar la informacion")
          ],

        ),
      );
    }else {
      print("Logueado");
      print(snapshot.data);
      user = User(
          name: snapshot.data.displayName,
          photoURL: snapshot.data.photoUrl,
          email: snapshot.data.email
      );
      final photo = Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.purpleAccent, width: 5.0),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: //AssetImage(user.photoURL)
              NetworkImage(user.photoURL),
            )
        ),
      );

      final nameUser = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: Text(
              user.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  fontFamily: "Aileron"
              ),
            ),
          ),
          Text(
            user.email,
            style: TextStyle(
                fontSize: 15.0
            ),
          )
        ],
      );

      final text = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 80.0),
            child: InkWell(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> IdeasUserInfo(user)))
              ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Text("My Ideas")
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("10"),
                      Icon(Icons.favorite, color: Colors.redAccent,)
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 120.0),
              child: InkWell(
                onTap: (){

                },
                child: Text("Editar",
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ),
              )
          )
        ],
      );


      return Container(
        margin: EdgeInsets.only(top: 120.0, left: 10.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            photo,
            nameUser,
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: text,
            )
          ],

        ),
      );
    }
  }
}
