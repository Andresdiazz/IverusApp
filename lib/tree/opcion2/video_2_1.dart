import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/tree/delayed_animation.dart';
import 'package:cocreacion/tree/opcion1/negativa.dart';
import 'package:cocreacion/tree/opcion2/positivo.dart';
import 'package:flutter/material.dart';


import 'package:video_player/video_player.dart';

import '../../Ideas/ui/screens/home_page.dart';


class Video_2_1 extends StatefulWidget {
  @override
  _Video_2_1State createState() => _Video_2_1State();
}

class _Video_2_1State extends State<Video_2_1> with SingleTickerProviderStateMixin {
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
        'https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/TREE%2Favena_inglehs%2FNORMAL%20HIDRATAS%20SIEMPRE.mp4?alt=media&token=ae6c67be-639b-4574-b801-0985eb0116cb')
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
                          height: 780.0,

                          child: InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));


                            },
                          ),
                        ),
                        Visibility(
                            visible: true,
                            child: Container(

                              width: 150.0,
                              height: 780.0,

                              child: InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));

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
