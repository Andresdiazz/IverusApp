import 'package:cocreacion/Comments/ui/ui/screens/submmit_comment.dart';
import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:flutter/cupertino.dart';

class  Slide extends StatelessWidget {

  final Ideas ideas;
  final User user;
  final VoidCallback onPressedFabIcon;



  Slide( this.ideas, this.user,  {Key key, this.onPressedFabIcon,} );

  @override
  Widget build(BuildContext context) {
    final like = Container(
        margin: EdgeInsets.only(
            left: 20.0,
            top: 10.0
        ),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: onPressedFabIcon,
              child: Icon(
                CupertinoIcons.heart,
                size: 20.0,
                color: Colors.black,
                //FontAwesomeIcons.heart,
                //size: 20.0,
                ),

            ),
            Container(
              margin: EdgeInsets.only(left: 1.0),
              child: Text(
                  '${this.ideas.likes}',
                style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54
                ),
              ),
            )

          ],
        )
    );

    final userComment = Container(
      margin: EdgeInsets.only(
          left: 20.0
      ),
      width: 280.0,

      child: Text(
        this.ideas.title,
        //"Hola",
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 15.0,
        ),
      ),
    );

    final userName = Container(
      margin: EdgeInsets.only(
          left: 20.0,
          top:10.0
      ),

      child: Text(
        //this.user.name,
        "Andres Diaz",
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 15.0,
            fontWeight: FontWeight.w900
        ),
      ),
    );

    final photo = Container (
      margin: EdgeInsets.only(
          left: 20.0, top: 15.0
      ),
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: //NetworkImage(this.user.photoURL)
            AssetImage("assets/img/profile.jpg")
          )
      ),
    );

    final share = Container(
        margin: EdgeInsets.only(
          left: 20.0,
          top: 10.0,
        ),
        child: InkWell(
          onTap: (){
            Share.share('chek my website https://www.excited.com.mx');
          }
            ,
          child: Icon(
            CupertinoIcons.share_up,
            //FontAwesomeIcons.shareAlt,
            size: 20.0,
          color: Colors.black54,)
        )
    );

    final comment = Container(
        margin: EdgeInsets.only(
          left: 20.0,
          top: 10.0,
        ),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=> SubmmitComments())
                );
              },
              child: Icon(
                CupertinoIcons.conversation_bubble,
                //FontAwesomeIcons.comment,
                size: 20.0,
                color: Colors.black,
              ),

            ),
            Container(
              margin: EdgeInsets.only(left: 1.0),
              child: Text(
                  "3",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54
                ),
              ),
            )

          ],
        )
    );

    final userDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        userName,
        userComment,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            comment,
            like,
            share,

          ],
        )
      ],
    );





    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.18,
      child: InkWell(
        onTap: (){},
        onDoubleTap: onPressedFabIcon,
        child: Container(
            height: 150.0,
            margin: EdgeInsets.only(top: 2.0),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                photo,
                userDetails
              ],
            )
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Disslike',
          color: Colors.red,
          icon: Icons.thumb_down,
          onTap: (){
          },
        )
      ],

      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Report',
          color: Colors.white10,
          icon: Icons.report,
          onTap: onPressedFabIcon,
          foregroundColor: Colors.red,
        )
      ],
    );


  }
}
