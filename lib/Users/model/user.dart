import 'package:flutter/material.dart';

import '../../ideas.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final List<Ideas> myIdeas;
  final List<Ideas> myFavoriteIdeas;

  User({
   Key key,
    @required this.uid,
   @required this.name,
   @required this.photoURL,
   @required this.email,
    this.myIdeas,
    this.myFavoriteIdeas
  });
}