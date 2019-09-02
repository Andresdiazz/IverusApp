import 'package:flutter/material.dart';

class Comments {
  String id;
  final String title;
  int likes;

  //User userOwner;

  Comments({
    Key key,
    @required this.title,
    //this.userOwner,
    this.likes,


  });
}