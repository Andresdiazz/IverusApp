
import 'package:cocreacion/Ideas/ui/screens/submmit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatingButton extends StatefulWidget {
  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Submmit()));
        },
        backgroundColor: Colors.blueGrey,
        //elevation: 30.0,
        child: Icon(Icons.lightbulb_outline),
        heroTag: null,



      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
