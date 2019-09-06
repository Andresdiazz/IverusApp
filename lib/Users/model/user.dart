import 'dart:convert';

import 'package:flutter/material.dart';

import '../../ideas.dart';

class User {
  String uid;
  String name;
  String email;
  String photoURL;
  int points;
  List<Ideas> myIdeas;
  List<Ideas> myFavoriteIdeas;

  User(
      {Key key,
      @required this.uid,
      @required this.name,
      @required this.photoURL,
      @required this.points,
      @required this.email,
      this.myIdeas,
      this.myFavoriteIdeas});

  @override
  String toString() {
    return JsonCodec().encode({
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoURL,
      'points': points,
    });
  }

  static User stringToObject(String json) {
    var data = JsonCodec().decode(json) as Map<String, dynamic>;
    return User.fromJson(data);
  }

  User.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return;
    json['uid'] == null ? uid = null : uid = json['uid'];
    json['name'] == null ? name = null : name = json['name'];
    json['email'] == null ? email = null : email = json['email'];
    json['photoURL'] == null ? photoURL = null : photoURL = json['photoURL'];
    json['points'] == null ? points = null : points = json['points'];
  }

  Map<String, dynamic> getMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;

    if (this.name != null) data['name'] = this.name;

    if (this.email != null) data['email'] = this.email;

    if (this.photoURL != null) data['photoURL'] = this.photoURL;

    if (this.points != null) data['points'] = this.points;

    return data;
  }
}
