import 'dart:convert';

import 'package:flutter/material.dart';

import '../../ideas.dart';
import 'likes.dart';

class User {
  String uid;
  String name;
  String email;
  String photoURL;
  String gift;
  String phone;
  String desc;
  int points;
  Likes likes;
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
      'likes': likes.toString(),
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
    json['phone'] == null ? phone = null : phone = json['phone'];
    json['desc'] == null ? desc = null : desc = json['desc'];
    likes = json['likes'] != null ? new Likes.fromJson(json['likes']) : null;
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
    if (this.likes != null) data['likes'] = this.likes.toJson();

    return data;
  }
}
