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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<LiveVideoModel>(
            stream: null,
            builder: (context, snapshot) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  getVideoPlayer(),
                  showOptions ? getButtons() : Container()
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

  Widget getButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: Alignment(0, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
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
                  "Yes",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(
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
                  "Other",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(
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
                  "No",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  playVideo(String id) {
    _controllerVideo =
        VideoPlayerController.asset("assets/videos/ACNE_QUESTION.MP4")
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {
              _controllerVideo.play();
            });
          })
          ..addListener(() {
            if (_controllerVideo.value.position.inSeconds == 12) {
              setState(() {
                showOptions = true;
              });
            }
            ;
          });
  }
}
