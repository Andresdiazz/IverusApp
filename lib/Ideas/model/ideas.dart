import 'package:cocreacion/Users/model/user.dart';
import 'package:flutter/material.dart';

class Ideas {
  String id;
  final String title;
  int likes;
  bool liked;


  //User userOwner;

  Ideas({
   Key key,
   @required this.title,
    //this.userOwner,
    this.likes,
    this.liked,
    this.id


});
}