import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {
  @override
  _BackgroundVideoState createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {

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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
    );
  }
}


class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF05C3DD),
              //Colors.deepPurpleAccent,
              const Color(0xFF87189d),
            ],
            //stops: [0.2, 0.7],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
        ),
        /*image: DecorationImage(
            image: AssetImage("assets/img/fondos1.jpg"),
          fit: BoxFit.cover,
          //colorFilter: ColorFilter.mode(Colors.blueGrey),
        ),*/
      ),
    );
  }
}
