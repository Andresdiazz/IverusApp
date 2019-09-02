import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';



class IdeasUser extends StatelessWidget {

  final Ideas ideas;
  final User user;

  IdeasUser(this.ideas, this.user);

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
              onTap: (){},
              child: Icon(Icons.favorite_border,
                size: 20.0,),

            ),
            Text('${this.ideas.likes}'

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
        //widget.comment,
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
      "Alberto",//this.user.name,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 17.0,
            fontWeight: FontWeight.w600
        ),

      ),

    );


    final photo = Container (
      margin: EdgeInsets.only(
          left: 20.0
      ),

      width: 40.0,
      height: 40.0,

      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/img/profile.jpg")
          )
      ),

    );

    final userDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        userName,
        userComment,
        like

      ],
    );





    return Container(
      child: ListView(

        children: <Widget>[
          Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.18,
            child: InkWell(
              onTap: (){},
              child: Container(
                  height: 150.0,
                  margin: EdgeInsets.only(top: 2.0),
                  color: Colors.white,
                  child: Row(
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
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.thumb_down,
                onTap: (){},
              )
            ],
          )
        ],
      ),
    );




  }
}
