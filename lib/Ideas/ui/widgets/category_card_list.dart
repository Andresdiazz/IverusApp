import 'package:flutter/material.dart';

import 'category_card.dart';

class CategoryCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      width: 500.0,
      child: ListView(
        padding: EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryCard("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fcuidado_personal.jpg?alt=media&token=3210f46f-e9d3-4fd7-83fe-dde4c0c23814",),
          CategoryCard("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fbienestar.jpg?alt=media&token=092718b8-887b-495f-adfb-57ef374b860a"),
          CategoryCard("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fmoda.jpg?alt=media&token=6356ff76-6ecb-4530-bb45-989e871a9234"),
        ],
      ),
    );
  }
}
