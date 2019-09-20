import 'dart:convert';

import 'package:flutter/material.dart';

import '../../ideas.dart';

class User {
  String uid;
  String name;
  String email;
  String photoURL;
  String gift;
  String phone;
  String desc;
  int points;
  List<String> likes;
  List<Ideas> myIdeas;
  List<Ideas> myFavoriteIdeas;

  User(
      {Key key,
      @required this.uid,
      @required this.name,
      @required this.photoURL,
      @required this.points,
      @required this.email,
      this.gift,
      @required this.phone,
      @required this.desc,
      this.likes,
      this.myIdeas,
      this.myFavoriteIdeas});

  @override
  String toString() {
    return JsonCodec().encode({
      'uid': uid,
      'name': name,
      'email': email,
      'photoURL': photoURL,
      'points': points,
      'phone': phone,
      'desc': desc,
      'likes': likes,
    });
  }

  static User stringToObject(String json) {
    var data = JsonCodec().decode(json) as Map<String, dynamic>;
    return User.fromJson(data);
  }

  User.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return;
    uid = json['uid'] == null ? null : json['uid'];
    name = json['name'] == null ? null : json['name'];
    email = json['email'] == null ? null : json['email'];
    photoURL = json['photoURL'] == null ? null : json['photoURL'];
    points = json['points'] == null ? null : json['points'];
    phone = json['phone'] == null ? null : json['phone'];
    desc = json['desc'] == null ? null : json['desc'];
    likes = json['likes'] != null ? json['likes'] : null;
  }

  Map<String, dynamic> getMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;

    if (this.name != null) data['name'] = this.name;

    if (this.email != null) data['email'] = this.email;

    if (this.photoURL != null) data['photoURL'] = this.photoURL;

    if (this.points != null) data['points'] = this.points;
    if (this.phone != null) data['phone'] = this.phone;
    if (this.desc != null) data['desc'] = this.desc;
    if (this.likes != null) data['likes'] = this.likes;

    return data;
  }
}
