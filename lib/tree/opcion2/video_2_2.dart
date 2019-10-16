import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/tree/delayed_animation.dart';
import 'package:cocreacion/tree/opcion1/negativa.dart';
import 'package:cocreacion/tree/opcion2/positivo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';

import 'package:video_player/video_player.dart';



class Video_2_2 extends StatefulWidget {
  @override
  _Video_2_2State createState() => _Video_2_2State();
}

class _Video_2_2State extends State<Video_2_2> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  VideoPlayerController _controllervideo;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
    _controllervideo = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/TREE%2Favena_inglehs%2FNORMAL%20HIDRATAS%20NUNCA.mp4?alt=media&token=9d72af33-92d5-419e-82c9-917a768f785f')
        ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controllervideo.play();
        });
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
                             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Positiva()));


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
                                  //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ()));

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
