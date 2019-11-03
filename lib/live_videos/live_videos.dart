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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<LiveVideoModel>(
            stream: _bloc.video,
            builder: (context, AsyncSnapshot<LiveVideoModel> snapshot) {
              return snapshot.data != null
                  ? LiveVideoPlayer(this._bloc, snapshot.data.url)
                  : Container();
            }));
  }
}

class LiveVideoPlayer extends StatefulWidget {
  LiveVideosBloc _bloc;
  String url;

  LiveVideoPlayer(this._bloc, this.url);

  @override
  _VideoPlayer createState() => _VideoPlayer();
}

class _VideoPlayer extends State<LiveVideoPlayer> {
  VideoPlayerController _controllerVideo;
  bool showOptions = false;
  int endPoint = 0;
  int askAtId = 0;
  bool showBufferingLoader = false;

  @override
  void initState() {
    super.initState();
    playVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        getVideoPlayer(),
        showOptions
            ? getButtons(widget._bloc.getOptions(askAtId.toString()))
            : Container(),
        Center(
          child:
              showBufferingLoader ? CircularProgressIndicator() : Container(),
        )
      ],
    ));
  }

  playVideo() {
    _controllerVideo = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controllerVideo.play();
        });
      })
      ..addListener(() {
        setState(() {
          showBufferingLoader = _controllerVideo.value.isBuffering;
        });

// we will start showing options from here, it will show for 4 seconds
        if (widget._bloc.showPoints
            .contains(_controllerVideo.value.position.inSeconds.toString())) {
          askAtId = _controllerVideo.value.position.inSeconds;
          endPoint = _controllerVideo.value.position.inSeconds + 4;

          print("AskAtId:   " + askAtId.toString());
          print("EndPoint:  " + endPoint.toString());

          setState(() {
            showOptions = true;
          });
        }

//       if options are shown and no option is selected until, we will proceed with default option
        if (_controllerVideo.value.position.inSeconds == endPoint) {
          print("OPTIONS  :" +
              widget._bloc.getOptions(askAtId.toString()).toString());
          hideOptionsAndSeek(
              widget._bloc.getOptions(askAtId.toString())['Default']);
        }
      });
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
//    options.remove('Default');

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              yesButton(options.keys
                  .toList()
                  .lastWhere((data) => data.toString().startsWith("1_"))),
              options.length > 3
                  ? otherButton(options.keys
                      .toList()
                      .lastWhere((data) => data.toString().startsWith("2_")))
                  : Container(),
              options.length > 3
                  ? noButton(options.keys
                      .toList()
                      .lastWhere((data) => data.toString().startsWith("3_")))
                  : noButton(options.keys
                      .toList()
                      .lastWhere((data) => data.toString().startsWith("2_")))
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          )
        ],
      ),
    );
  }

  yesButton(String text) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                radius: 1, colors: [Colors.black87, Colors.grey]),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(90),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(90)),
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text.substring(2, text.length),
            style:
                Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        hideOptionsAndSeek(widget._bloc.getOptions(askAtId.toString())[text]);
      },
    );
  }

  otherButton(String text) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(90),
                topLeft: Radius.circular(90),
                topRight: Radius.circular(90)),
            gradient: RadialGradient(
                radius: 1, colors: [Colors.black87, Colors.grey]),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text.substring(2, text.length),
            style:
                Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        hideOptionsAndSeek(widget._bloc.getOptions(askAtId.toString())[text]);
      },
    );
  }

  noButton(String text) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(90),
                topRight: Radius.circular(0)),
            gradient: RadialGradient(
                radius: 1, colors: [Colors.black87, Colors.grey]),
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text.substring(2, text.length),
            style:
                Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        hideOptionsAndSeek(widget._bloc.getOptions(askAtId.toString())[text]);
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
