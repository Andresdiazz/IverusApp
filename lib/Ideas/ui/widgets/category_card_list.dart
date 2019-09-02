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
          CategoryCard("assets/img/cuidado_personal.jpg",),
          CategoryCard("assets/img/bienestar.jpg"),
          CategoryCard("assets/img/moda.jpg"),
        ],
      ),
    );
  }
}
