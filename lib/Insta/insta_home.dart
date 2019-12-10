import 'package:cocreacion/Insta/insta_body.dart';
import 'package:flutter/material.dart';

class InstHome extends StatelessWidget {

   final topBar = new AppBar(
    backgroundColor: new Color(0xfff8faf8),
    centerTitle: true,
    elevation: 1.0,
    leading: new Icon(Icons.arrow_back_ios , color: Colors.black,),
    title: SizedBox(
      height: 25.0, child: Image.network("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2FLOGO-IVERUS-NEGRO.png?alt=media&token=af898df2-cd8d-44f8-bc83-864000bab447")),
      actions: <Widget>[
        /*Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.send, color: Colors.black),
        )*/
      ],
   );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: topBar,
          body: InstaBody(),
    );
  }
}