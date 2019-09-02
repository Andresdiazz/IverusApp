import 'package:cocreacion/Users/model/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardProfile extends StatefulWidget {
  
  
  
  @override
  _CardProfileState createState() => _CardProfileState();
}

class _CardProfileState extends State<CardProfile> {

  User user;

  @override
  Widget build(BuildContext context) {

    if(user != null){

    };

    final ideaInsignia = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [

          ]
      ),
      child: Card(
        //color: Colors.amber,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Icon(FontAwesomeIcons.lightbulb, size: 50.0,color: Colors.black26,)
        //Icon(Icons.comment, color: Colors.black26, size: 70.0,),

      ),

    );

    final commentInsignia = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [

          ]
      ),
      child: Card(
        //color: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Icon(FontAwesomeIcons.commentDots, size: 50.0,color: Colors.black26,)
        //Icon(Icons.comment, color: Colors.black26, size: 70.0,),

      ),

    );

    final profileInsignia = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [

          ]
      ),
      child: Card(
        //color: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Icon(FontAwesomeIcons.userCircle, color: Colors.black26, size: 50.0,)
        //Icon(Icons.account_circle, color: Colors.black26, size: 70.0,),

      ),

    );

    final shopInsignia = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [

          ]
      ),
      child: Card(
        //color: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Icon(FontAwesomeIcons.shoppingCart, color: Colors.black26, size: 50.0,)
        //Icon(Icons.shopping_cart, color: Colors.black26, size: 70.0,),

      ),

    );

    final shareInsignia = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [

          ]
      ),
      child: Card(
        //color: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Icon(FontAwesomeIcons.shareAltSquare, color: Colors.black26, size: 50.0,)
        //Icon(Icons.share, color: Colors.black26, size: 70.0,),

      ),

    );

    final partyInsignia = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [

          ]
      ),
      child: Card(
        //color: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Icon(FontAwesomeIcons.glassCheers, color: Colors.black26, size: 50.0,)
        //Icon(Icons.looks, color: Colors.black26, size: 70.0,),

      ),

    );


    final card = Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
              Container(
                margin: EdgeInsets.only(),
                child: ideaInsignia,
              ),
            commentInsignia
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(),
              child: profileInsignia,
            ),
            shareInsignia
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(),
              child: shopInsignia,
            ),
            partyInsignia
          ],
        )
      ],
    );


    return card;
  }
}
