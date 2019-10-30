import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/tree/delayed_animation.dart';
import 'package:cocreacion/tree/opcion1/negativa.dart';
import 'package:cocreacion/tree/opcion1/positivo.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';


class Video_1_1 extends StatefulWidget {
  String idVideo;
  String tipo;
  Video_1_1(this.idVideo,this.tipo);
  @override
  _Video_1_1State createState() => _Video_1_1State(this.idVideo,this.tipo);
}

class _Video_1_1State extends State<Video_1_1> with SingleTickerProviderStateMixin {

  VideoPlayerController _controllervideo;

  _Video_1_1State(String idVideo,String tipo);

  @override
  void initState() {

    super.initState();
    Firestore.instance
        .collection (widget.tipo)
        .document(widget.idVideo).collection('0').document('1_1')
        .snapshots().forEach((doc)=> {
      _controllervideo = VideoPlayerController.network( doc.data['video'])
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Positiva(widget.idVideo,widget.tipo)));


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
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Negativa(widget.idVideo,widget.tipo)));

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
