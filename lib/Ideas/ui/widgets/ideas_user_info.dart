import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/ui/screens/user_ideas.dart';
import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class IdeasUserInfo extends StatelessWidget {

  UserBloc userBloc;
  User user;

  IdeasUserInfo(@required this.user);

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of<UserBloc>(context);

    Ideas ideas = Ideas(
      title: "Hola",
      likes: 0
    );

    final buttonBack = InkWell(
        onTap: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfileScreen()));
        },
        child: Icon(Icons.arrow_back_ios),

    );


    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.white
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50.0),
            child: StreamBuilder(
                stream: userBloc.ideasStream,
                builder: (context, AsyncSnapshot snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.waiting:
                      // TODO: Handle this case.
                        return CircularProgressIndicator();
                      case ConnectionState.active:
                      // TODO: Handle this case.
                        return Column(
                          children:
                          userBloc.buildIdeas(snapshot.data.documents, user),

                        );
                      case ConnectionState.done:
                      // TODO: Handle this case.
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                          children:
                          userBloc.buildIdeas(snapshot.data.documents, user),
                        );
                      case ConnectionState.none:
                      // TODO: Handle this case.
                        return CircularProgressIndicator();
                      default:
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                          children:
                          userBloc.buildIdeas(snapshot.data.documents, user),
                        );

                    }

                   /**/
                }
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 10.0),
            height: 90.0,
            width: 30.0,
            color: Colors.white,
            child: buttonBack,
          ),
        ],
      ),
    );
  }
}

/*ListView(
      children: <Widget>[
        IdeasUser(name: "Alberto", comment: "Pueden desarrollar un bálsamo para labios que humecte los labios pero que no tenga color ni brillo. Me gustaría que fuera sabor maracuya.",
          pathImage: "assets/img/profile.jpg",
        ),
        IdeasUser(name: "Carlos", comment: "Quiero un bálsamo para crecimiento de barba que pueda usar varias veces al día",
            pathImage: "assets/img/profile2.jpg"),
        IdeasUser(name: "Alan", comment: "Me gustaría un desodorante que no tenga toxinas ni metales pesados.",
            pathImage: "assets/img/profile3.jpg"),
        IdeasUser(name: "Carlos", comment: "Sugiero un exfoliante facial removedor de impurezas con carbon activado",
            pathImage: "assets/img/profile2.jpg"),
        IdeasUser(name: "Alberto", comment: "Me gustaría una crema para afeitar que no me irrite la cara",
            pathImage: "assets/img/profile.jpg"),
        IdeasUser(name: "Alan", comment: "Quiero un bubble butt con fragancia mango-coco",
            pathImage: "assets/img/profile3.jpg")
      ],
    );*/