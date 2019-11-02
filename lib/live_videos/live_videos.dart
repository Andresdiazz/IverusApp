import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'live_video_model.dart';
import 'live_videos_bloc.dart';

class LiveVideos extends StatefulWidget {
  @override
  _LiveVideosState createState() => _LiveVideosState();
}

class _LiveVideosState extends State<LiveVideos> {
  LiveVideosBloc _bloc = LiveVideosBloc();
  VideoPlayerController _controllerVideo;
  bool showOptions = false;
  int endPoint = 0;
  int askAtId = 0;

  @override
  void initState() {
    super.initState();
    playVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<LiveVideoModel>(
            stream: _bloc.video,
            builder: (context, snapshot) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  getVideoPlayer(),
                  showOptions
                      ? getButtons(_bloc.getOptions(askAtId.toString()))
                      : Container()
                ],
              );
            }));
  }

  Widget getVideoPlayer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        child: _controllerVideo.value.initialized
            ? AspectRatio(
                aspectRatio: _controllerVideo.value.aspectRatio,
                child: VideoPlayer(_controllerVideo),
              )
            : Container(),
      ),
    );
  }

  Widget getButtons(Map<dynamic, dynamic> options) {
    options.remove('Default');

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              yesButton(options.keys.toList()[0]),
              options.length > 2
                  ? otherButton(options.keys.toList()[1])
                  : Container(),
              noButton(options.keys.toList()[options.length > 2 ? 2 : 1]),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          )
        ],
      ),
    );
  }

  playVideo() {
    _controllerVideo = VideoPlayerController.asset("assets/videos/test.MP4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controllerVideo.play();
        });
      })
      ..addListener(() {
// we will start showing options from here, it will show for 4 seconds
        if (_bloc.showPoints
            .contains(_controllerVideo.value.position.inSeconds.toString())) {
          askAtId = _controllerVideo.value.position.inSeconds;
          endPoint = _controllerVideo.value.position.inSeconds + 4;
          setState(() {
            showOptions = true;
          });
        }

//       if options are shown and no option is selected until, we will proceed with default option
        if (_controllerVideo.value.position.inSeconds == endPoint) {
          hideOptionsAndSeek(_bloc.getOptions(askAtId.toString())['Default']);
        }
      });
  }

  yesButton(String text) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(90),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(90)),
            color: Colors.black87,
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style:
                Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        hideOptionsAndSeek(_bloc.getOptions(askAtId.toString())[text]);
      },
    );
  }

  noButton(String text) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(90),
                topLeft: Radius.circular(90),
                topRight: Radius.circular(90)),
            color: Colors.black87,
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style:
                Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        hideOptionsAndSeek(_bloc.getOptions(askAtId.toString())[text]);
      },
    );
  }

  otherButton(String text) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(90),
                topRight: Radius.circular(0)),
            color: Colors.black87,
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style:
                Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        hideOptionsAndSeek(_bloc.getOptions(askAtId.toString())[text]);
      },
    );
  }

  hideOptionsAndSeek(int position) {
    endPoint = 0;
    setState(() {
      if (showOptions) {
        _controllerVideo.seekTo(Duration(seconds: position));
        showOptions = false;
      }
    });
  }
}
