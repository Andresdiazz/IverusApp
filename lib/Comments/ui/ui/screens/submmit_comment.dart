import 'package:cocreacion/Comments/model/comments.dart';
import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/ui/widgets/button_submmit.dart';
import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';


class SubmmitComments extends StatefulWidget {
  @override
  _SubmmitCommentsState createState() => _SubmmitCommentsState();
}

class _SubmmitCommentsState extends State<SubmmitComments> {

  final _controllerComment = TextEditingController();

  Ideas ideas;

  @override
  Widget build(BuildContext context) {

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    final background = Flexible(
      child: Container(
        color: Colors.white,
        height: 550.0,
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 90.0,
            width: 450.0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ButtonSubmmit(text: "Cancelar", right: 150.0, left: 10.0, color: Colors.white, icon: null, colorFont: Colors.blue,
                    onPressed: () =>
                        Navigator.pop(context)

                ),
                ButtonSubmmit(text: "Comentar", right: 10.0,left: 5.0, color: Colors.blue,icon: null, colorFont: Colors.white,
                  onPressed: () {
                    //firebase Storage
                    //Cloud Firestore
                    //Idea - Title, likes, userOwner, likes
                    userBloc.updateComments(
                      Comments(
                        title: _controllerComment.text,
                        likes: 0,
                      ))
                      .whenComplete((){
                      print("TERMINO");
                      Navigator.pop(context);
                    });
                  },
                )

              ],
            ),
          ),
          Input(),
          background
        ],
      ),
    );
  }

  Widget Input(){
    final photo = Container (
      margin: EdgeInsets.only(
          top: 0.0,
          left: 20.0
      ),

      width: 50.0,
      height: 50.0,

      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fprofile.jpg?alt=media&token=7621fac2-a428-44df-ab06-0336740602d7")
          )
      ),

    );

    final inputText = Flexible(

        child: Container(
          margin: EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: _controllerComment,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Escribe algo",



            ),

          ),)
    );



    return Container(
      color: Colors.white,
      //height: 350.0,
      child: Row(
        children: <Widget>[
          photo,
          inputText,
          //background
        ],
      ),
    );
  }
}