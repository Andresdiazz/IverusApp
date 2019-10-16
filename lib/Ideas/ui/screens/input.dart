import 'package:flutter/material.dart';

class Input extends StatelessWidget {

  TextInputType comment;

  Input({Key key, this.comment});



  @override
  Widget build(BuildContext context) {

    final _controllerComment = TextEditingController();

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
