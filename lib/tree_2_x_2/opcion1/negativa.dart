import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';




class Negativa_2_X_2 extends StatefulWidget {
  String idVideo;
  String tipo;
  Negativa_2_X_2(this.idVideo,this.tipo);
  @override
  _Negativa_2_X_2State createState() => _Negativa_2_X_2State(this.idVideo,this.tipo);
}

class _Negativa_2_X_2State extends State<Negativa_2_X_2> with SingleTickerProviderStateMixin {

  VideoPlayerController _controllervideo;

  _Negativa_2_X_2State(String idVideo,String tipo);


  @override
  void initState() {

    super.initState();
    Firestore.instance
        .collection (widget.tipo)
        .document(widget.idVideo).collection('0').document('1_negativo')
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
                  child: _controllervideo?.value?.initialized ?? false
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
                              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Positiva()));


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
                                  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Negativa()));

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