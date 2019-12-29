import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'Animated/Share.dart';
import 'Animated/heart.dart';

void main() => runApp(VideoApp());

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {

    final topBar = new AppBar(
      backgroundColor: new Color(0xfff8faf8),
      centerTitle: true,
      elevation: 1.0,
      title: SizedBox(
          height: 25.0, child: Image.network("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2FLOGO-IVERUS-NEGRO.png?alt=media&token=af898df2-cd8d-44f8-bc83-864000bab447")),
      actions: <Widget>[
        /*Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.send, color: Colors.black),
        )*/
      ],
    );

    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: topBar,
        body: PageView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  child: Center(
                    child: _controller.value.initialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : Container(),
                  ),
                ),
                Container(
                    //color: Colors.grey,
                    alignment: Alignment.bottomRight,
                    //padding: EdgeInsets.only(top: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        AnimatedLikeButton(),
                        SizedBox(
                          width: 10.0,
                        ),
                        AnimatedShareButton(),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    )),
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  child: Center(
                    child: _controller.value.initialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : Container(),
                  ),
                ),
                Container(
                  //color: Colors.grey,
                    alignment: Alignment.bottomRight,
                    //padding: EdgeInsets.only(top: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        AnimatedLikeButton(),
                        SizedBox(
                          width: 10.0,
                        ),
                        AnimatedShareButton(),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}