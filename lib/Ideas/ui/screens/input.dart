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
              image: AssetImage("assets/img/profile.jpg")
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
