import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:cocreacion/tree/opcion1/video_1.dart';
import 'package:cocreacion/tree/opcion2/video_2.dart';
import 'package:cocreacion/tree_2_x_2/opcion1/video_1.dart';
import 'package:cocreacion/tree_2_x_2/opcion2/video_2.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class Intro_2_x_2 extends StatefulWidget {
  final CategoryItem documentData;
  Intro_2_x_2({this.documentData});

  @override
  _Intro_2_x_2State createState() => _Intro_2_x_2State();
}

class _Intro_2_x_2State extends State<Intro_2_x_2> with SingleTickerProviderStateMixin {
  VideoPlayerController _controllervideo;

  void initState() {
    super.initState();
    Firestore.instance
        .collection (widget.documentData.tipo)
        .document(widget.documentData.name).collection('0').document('0')
        .snapshots().forEach((doc)=> {
      _controllervideo = VideoPlayerController.network( doc.data['video'])
        ..initialize().then((_) {
          setState(() {
            _controllervideo.play();
          });
        })

    });
  }




  var _opacity = 0.0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(

          child:Stack(
            children: <Widget>[
              Container(
                height: 812.0,
                width: 420.0,
                child: _controllervideo.value.initialized
                    ? AspectRatio(
                  aspectRatio: _controllervideo.value.aspectRatio,
                  child: VideoPlayer(_controllervideo),
                )
                    : Container(),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        height: 810.0,

                        child: InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Video_1_2X_2(widget.documentData.name,widget.documentData.tipo)));


                          },
                        ),
                      ),
                      Visibility(
                        visible: true,
                          child: Container(

                            width: 175.0,
                            height: 810.0,

                            child: InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Video_2_2_X_2(widget.documentData.name,widget.documentData.tipo)));

                              },
                            ),
                          )
                      )

                    ],
                  ),
                ],
              ),
            ],
          )

        ),
      ),

    );

  }
  @override
  void dispose() {
    super.dispose();
    _controllervideo.dispose();
  }
}
