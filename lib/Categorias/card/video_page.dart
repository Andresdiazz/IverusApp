import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final CategoryItem documentData;
  final CategoriesBloc categoriesBloc;
  final String table;

  VideoPage({this.documentData, this.categoriesBloc, this.table});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  VideoPlayerController _controllervideo;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _controllervideo = VideoPlayerController.network(widget.documentData.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controllervideo.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: GestureDetector(
                onTap: () {
                  if (_controller.isCompleted) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                },
                child: _controllervideo.value.initialized
                    ? AspectRatio(
                        aspectRatio: _controllervideo.value.aspectRatio,
                        child: VideoPlayer(_controllervideo),
                      )
                    : Container(),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, -_controller.value * 84),
                    child: Container(
                      height: 84.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, top: 20),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, _controller.value * 84),
                    child: Container(
                      height: 84.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () async {
                                try {
                                  var request = await HttpClient().getUrl(
                                      Uri.parse(widget.documentData.video));
                                  var response = await request.close();
                                  Uint8List bytes =
                                      await consolidateHttpClientResponseBytes(
                                          response);
                                  await Share.file('Iverus', 'iverus.mp4',
                                      bytes, 'image/mp4');
                                  widget.categoriesBloc.updateShare(
                                      widget.documentData.id, widget.table);
                                } catch (e) {
                                  print('error: $e');
                                }
                              },
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 1.0),
                              child: AnimatedLikeButton(
                                table: widget.table,
                                categoriesBloc: widget.categoriesBloc,
                                documentData: widget.documentData,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.categoriesBloc.videoClick(widget.documentData.id);
    _controllervideo.dispose();
  }
}

class AnimatedLikeButton extends StatefulWidget {
  final CategoriesBloc categoriesBloc;
  final String table;
  final CategoryItem documentData;

  AnimatedLikeButton(
      {this.categoriesBloc, this.table, this.documentData, Key key})
      : super(key: key);

  @override
  _AnimatedLikeButtonState createState() => _AnimatedLikeButtonState();
}

enum LikeWidgetStatus { HIDDEN, BECOMING_VISIBLE, VISIBLE, BECOMING_INVISIBLE }

class _AnimatedLikeButtonState extends State<AnimatedLikeButton>
    with TickerProviderStateMixin {
  int _counter = 0;
  double _sprinklesAngle = 0.0;
  LikeWidgetStatus _likeWidgetStatus = LikeWidgetStatus.HIDDEN;
  final mainDuration = Duration(milliseconds: 400);
  final oneSecond = Duration(seconds: 1);
  Random random;
  Timer holdTimer, likeOutETA;
  AnimationController likeInAnimationController,
      likeOutAnimationController,
      likeSizeAnimationController,
      sparklesAnimationController;
  Animation likeOutPositionAnimation, sparklesAnimation;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Stack(
          alignment: FractionalOffset.center,
          overflow: Overflow.visible,
          children: <Widget>[
            getScoreButton(),
            getLikeButton(),
          ],
        ));
  }

  Widget getLikeButton() {
    var extraSize = 0.0;
    if (_likeWidgetStatus == LikeWidgetStatus.VISIBLE ||
        _likeWidgetStatus == LikeWidgetStatus.BECOMING_VISIBLE) {
      extraSize = likeSizeAnimationController.value * 3;
    }
    return GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: Container(
          height: 60.0 + extraSize,
          width: 60.0 + extraSize,
          padding: EdgeInsets.all(10.0),
          /*decoration: BoxDecoration(
              border: Border.all(color: Color(0xff23A8C5), width: 1.0),
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Color(0xff23A8C5), blurRadius: 8.0)]),*/
          child: getHeartIcon(),
        ));
  }

  initState() {
    super.initState();
    random = Random();
    _counter = widget.categoriesBloc.getLikes(widget.documentData.id);

    likeInAnimationController =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    likeInAnimationController.addListener(() {
      setState(() {}); // Calls render function
    });

    likeOutAnimationController =
        AnimationController(vsync: this, duration: mainDuration);
    likeOutPositionAnimation = Tween(begin: 100.0, end: 150.0).animate(
        CurvedAnimation(
            parent: likeOutAnimationController, curve: Curves.easeOut));
    likeOutPositionAnimation.addListener(() {
      setState(() {});
    });
    likeOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _likeWidgetStatus = LikeWidgetStatus.HIDDEN;
      }
    });

    likeSizeAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    likeSizeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        likeSizeAnimationController.reverse();
      }
    });
    likeSizeAnimationController.addListener(() {
      setState(() {});
    });

    sparklesAnimationController =
        AnimationController(vsync: this, duration: mainDuration);
    sparklesAnimation = CurvedAnimation(
        parent: sparklesAnimationController, curve: Curves.easeIn);
    sparklesAnimation.addListener(() {
      setState(() {});
    });
  }

  dispose() {
    super.dispose();
    likeInAnimationController.dispose();
    likeOutAnimationController.dispose();
  }

  void increment(Timer t) {
    widget.categoriesBloc.updateLike(widget.documentData.id, widget.table);
    likeSizeAnimationController.forward(from: 0.0);
    sparklesAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
      _sprinklesAngle = random.nextDouble() * (2 * pi);
    });
  }

  void onTapDown(TapDownDetails tap) {
    // User pressed the button. This can be a tap or a hold.
    if (likeOutETA != null) {
      likeOutETA.cancel(); // We do not want the score to vanish!
    }
    if (_likeWidgetStatus == LikeWidgetStatus.BECOMING_INVISIBLE) {
      // We tapped down while the widget was flying up. Need to cancel that animation.
      likeOutAnimationController.stop(canceled: true);
      _likeWidgetStatus = LikeWidgetStatus.VISIBLE;
    } else if (_likeWidgetStatus == LikeWidgetStatus.HIDDEN) {
      _likeWidgetStatus = LikeWidgetStatus.BECOMING_VISIBLE;
      likeInAnimationController.forward(from: 0.0);
    }
    increment(null); // Take care of tap
    holdTimer = Timer.periodic(mainDuration, increment); // Takes care of hold
  }

  void onTapUp(TapUpDetails tap) {
    // User removed his finger from button.
    likeOutETA = Timer(oneSecond, () {
      likeOutAnimationController.forward(from: 0.0);
      _likeWidgetStatus = LikeWidgetStatus.BECOMING_INVISIBLE;
    });
    holdTimer.cancel();
  }

  Widget getScoreButton() {
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    var extraSize = 0.0;
    switch (_likeWidgetStatus) {
      case LikeWidgetStatus.HIDDEN:
        break;
      case LikeWidgetStatus.BECOMING_VISIBLE:
      case LikeWidgetStatus.VISIBLE:
        scorePosition = likeInAnimationController.value * 100;
        scoreOpacity = likeInAnimationController.value;
        extraSize = likeSizeAnimationController.value * 3;
        break;
      case LikeWidgetStatus.BECOMING_INVISIBLE:
        scorePosition = likeOutPositionAnimation.value;
        scoreOpacity = 1.0 - likeOutAnimationController.value;
    }

    var stackChildren = <Widget>[];

    var firstAngle = _sprinklesAngle;
    var sprinkleRadius = (sparklesAnimationController.value * 50);
    var sprinklesOpacity = (1 - sparklesAnimation.value);

    for (int i = 0; i < 5; ++i) {
      var currentAngle = (firstAngle + ((2 * pi) / 5) * (i));
      var sprinklesWidget = Positioned(
        child: Transform.rotate(
            angle: currentAngle - pi / 2,
            child: Opacity(
                opacity: sprinklesOpacity,
                child: Image.asset(
                  "assets/sprinkle.png",
                  width: 14.0,
                  height: 14.0,
                ))),
        left: (sprinkleRadius * cos(currentAngle)) + 20,
        top: (sprinkleRadius * sin(currentAngle)) + 20,
      );
      stackChildren.add(sprinklesWidget);
    }

    stackChildren.add(Opacity(
        opacity: scoreOpacity,
        child: Container(
            height: 50.0 + extraSize,
            width: 50.0 + extraSize,
            decoration: ShapeDecoration(
              shape: CircleBorder(side: BorderSide.none),
              color: Color(0xff721385),
            ),
            child: Center(
                child: Text(
              "+" + _counter.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            )))));

    var widget = Positioned(
        child: Stack(
          alignment: FractionalOffset.center,
          overflow: Overflow.visible,
          children: stackChildren,
        ),
        bottom: scorePosition);
    return widget;
  }

  Widget getHeartIcon() {
    Widget imageIcon;
    if (_likeWidgetStatus == LikeWidgetStatus.VISIBLE ||
        _likeWidgetStatus == LikeWidgetStatus.BECOMING_VISIBLE) {
      imageIcon = Padding(
          padding: EdgeInsets.all(2),
          child: ImageIcon(AssetImage("assets/heart.png"),
              color: Color(0xff721385), size: 10.0));
    } else {
      imageIcon = Padding(
          padding: EdgeInsets.all(2),
          child: ImageIcon(AssetImage("assets/heart_filled.png"),
              color: Color(0xff721385), size: 10.0));
    }
    return imageIcon;
  }
}
