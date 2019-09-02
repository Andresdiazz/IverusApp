import 'package:cocreacion/Ideas/ui/screens/home.dart';
import 'package:flutter/material.dart';

class ButtonGeneral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 20.0),

      child: FloatingActionButton(
          onPressed: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home()));
          },
          child: Icon(Icons.close),
        heroTag: null,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
    );
  }
}
