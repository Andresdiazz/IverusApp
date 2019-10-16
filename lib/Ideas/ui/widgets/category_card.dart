import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {

  String pathImage = "https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fbanner.png?alt=media&token=71ee4cd9-e756-43d9-b08d-5c26d5ec5653";

  CategoryCard( this.pathImage);

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: 350.0,
      width: 250.0,
      margin: EdgeInsets.only(
          top: 20.0,
          left: 20.0

      ),

      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(pathImage)
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0, 7.0)
            )
          ]

      ),
    );

    return Stack(
      alignment: Alignment(0.9, 1.1),
      children: <Widget>[
        card,
      ],
    );
  }
}
