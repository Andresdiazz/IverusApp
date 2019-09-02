import 'package:cocreacion/Ideas/ui/screens/home.dart';
import 'package:flutter/material.dart';



class ButtonLogin extends StatefulWidget {

  //final String text;
  double top = 0;
  VoidCallback onPressed;
  IconData iconData;


  ButtonLogin({Key key, this.iconData, this.top, this.onPressed});

  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(
          top: widget.top,
          left: 20.0,
          right: 20.0,
          bottom: 10.0
        ),
        width: 50.0,
        height: 50.0,
        /*decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70.0),
          gradient: LinearGradient(colors: [
            Colors.blueGrey,
            Colors.blueAccent
          ],
          begin: FractionalOffset(0.2, 0.0),
            end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 0.6],
            tileMode: TileMode.clamp
          )
        ),*/
        child: Center(
          child: Icon(widget.iconData, size: 30.0, color: Colors.blueGrey,)
          /*Text(
            widget.text,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),*/
        ),
      ),
    );
  }
}
