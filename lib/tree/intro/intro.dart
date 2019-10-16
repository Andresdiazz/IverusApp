import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/tree/opcion1/video_1.dart';
import 'package:cocreacion/tree/opcion2/video_2.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../delayed_animation.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> with SingleTickerProviderStateMixin {
  VideoPlayerController _controllervideo;

  @override
  void initState() {
    super.initState();
    _controllervideo = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/TREE%2Favena_inglehs%2FINTRO%20GRASA%20ZONA%20T.mp4?alt=media&token=6ecb446d-b7c9-4898-8cc5-7e837c609ede')
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Video_1()));


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
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Video_2()));

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
