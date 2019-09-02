import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide.dart';
import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class SlideList extends StatefulWidget {

  User user;

  SlideList(@required this.user);

  @override
  _SlideListState createState() => _SlideListState();

}

UserBloc userBloc;

class _SlideListState extends State<SlideList> {
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
            stream: userBloc.ideasStream,

            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                // TODO: Handle this case.
                  return CupertinoActivityIndicator();
                case ConnectionState.active:
                // TODO: Handle this case.
                  return Column(
                    children:
                    userBloc.buildIdeas(snapshot.data.documents, widget.user),
                  );
                case ConnectionState.done:
                // TODO: Handle this case.
                  return Column(
                    children:
                    userBloc.buildIdeas(snapshot.data.documents, widget.user),
                  );
                case ConnectionState.none:
                // TODO: Handle this case.
                  return CupertinoActivityIndicator();
                default:
                  return Column(
                    children:
                    userBloc.buildIdeas(snapshot.data.documents, widget.user),
                  );
              }
            },
          )
        ]
    );
  }

/*
  Widget ListViewIdeas(List<Ideas> ideas){

    void setLiked(Ideas ideas){
      setState(() {
        ideas.liked = !ideas.liked;
        userBloc.like(place, widget.user.uid);
      });
    }

    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;

    return ListView(
      children: ideas.map((ideas){
        return Slide(
          User(uid: user, name: null, photoURL: null, email: null),
          Ideas(title: null),
          onPressedFabIcon: ,
        )
      })
    );
  }
}
*/

}