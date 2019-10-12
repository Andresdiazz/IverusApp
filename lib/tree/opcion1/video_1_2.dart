import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/tree/delayed_animation.dart';
import 'package:cocreacion/tree/opcion1/negativa.dart';
import 'package:cocreacion/tree/opcion1/positivo.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';


class Video_1_2 extends StatefulWidget {
  @override
  _Video_1_2State createState() => _Video_1_2State();
}

class _Video_1_2State extends State<Video_1_2> with SingleTickerProviderStateMixin {
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
        'https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/TREE%2Favena_inglehs%2FACNE%CC%81%20TODO%20EL%20ROSTRO.mp4?alt=media&token=a77fc404-fed2-4c03-a471-16fb383884a3')
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Positiva()));


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
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Negativa()));

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
