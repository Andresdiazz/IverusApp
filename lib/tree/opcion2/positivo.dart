import 'package:cocreacion/tree/delayed_animation.dart';
import 'package:cocreacion/tree/intro/intro.dart';
import 'package:cocreacion/tree/opcion1/video_1_2.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';


class Positiva extends StatefulWidget {
  @override
  _PositivaState createState() => _PositivaState();
}

class _PositivaState extends State<Positiva> with SingleTickerProviderStateMixin {
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
        'https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/TREE%2FSi_avena.mp4?alt=media&token=474c6e10-b294-445d-97ed-e4481dad9284')
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
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF8185E2),
        body: Center(
          child: Column(
            children: <Widget>[
              DelayedAimation(
                child: Stack(
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
                    Container(
                      margin: EdgeInsets.only(top: 500, left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                              onDoubleTap: (){
                                setState(() {
                                  _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                                });
                              },
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Intro()));
                              },
                              child: Center(
                                  child: AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(seconds: 1),
                                    child: Container(
                                      height: 80,
                                      width:80,
                                      decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: Center(
                                        child: Text("Otra Vez",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                      ),
                                    ),
                                  )
                              )
                          ),
                          InkWell(
                              onDoubleTap: (){
                                setState(() {
                                  _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                                });
                              },
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Video_1_2()));
                              },
                              child: Center(
                                  child: AnimatedOpacity(
                                    opacity: _opacity,
                                    duration: Duration(seconds: 1),
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: Center(
                                        child: Text("Home",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                      ),
                                    ),
                                  )
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                delay: delayedAmount + 1000,
              ),
            ],
          ),
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
