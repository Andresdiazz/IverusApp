import 'package:flutter/material.dart';

class BackProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0)),
          gradient: LinearGradient(colors: [
            Colors.blueGrey,
            Colors.grey
          ],
            begin: FractionalOffset(0.2, 0.0),
            end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 0.6],
            tileMode: TileMode.clamp,
          )
      ),
    );
  }
}
