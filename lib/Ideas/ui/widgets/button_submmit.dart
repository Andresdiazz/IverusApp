import 'package:flutter/material.dart';



class ButtonSubmmit extends StatefulWidget {

  String text;
  final VoidCallback onPressed;
  double left;
  double right;
  Color color;
  Color colorFont;
  Icon icon;

  ButtonSubmmit({
    Key key,
    this.text,
    this.onPressed,
    this.left,
    this.right,
    this.color,
    this.colorFont,
    this.icon
  }
  );

  @override
  _ButtonSubmmitState createState() => _ButtonSubmmitState();
}

class _ButtonSubmmitState extends State<ButtonSubmmit> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
        widget.onPressed
        //Navigator.pop(context);
        ,
      child: Container(
        margin: EdgeInsets.only(top: 20.0, left: widget.left, right: widget.right),
        width: 90.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: widget.color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.text,
            style: TextStyle(
              color: widget.colorFont
            ),
            ),
          ],

        )

      ),

    );
  }
}
