import 'package:flutter/material.dart';

class Ideas extends StatefulWidget {
  @override
  _IdeasState createState() => _IdeasState();
}

class _IdeasState extends State<Ideas> {
  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          right: 20.0,
          left: 20.0
        ),
        width: 350.0,
        height: 70.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          border: Border.all(color: Colors.black12)

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Hola",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),),
            Text("Hola"),
          ],
        ),
      ),
    );
  }
}
