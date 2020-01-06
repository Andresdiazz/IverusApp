import 'dart:async';
import 'dart:math';

import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:flutter/material.dart';

class AnimatedLikeButton extends StatefulWidget {
  final CategoryItem documentData;
  final CategoriesBloc bloc;

  AnimatedLikeButton({Key key, this.documentData, this.bloc}) : super(key: key);

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
    return Container(
        //margin: EdgeInsets.only(left: 220.0,top:700.0),
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
    _counter = widget.bloc.getLikes(widget.documentData.id);

    random = Random();
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

  //Incrementador de like
  void increment(Timer t) {
    widget.bloc.updateLike(widget.documentData.id, widget.bloc.category);

    likeSizeAnimationController.forward(from: 0.0);
    sparklesAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
      _sprinklesAngle = random.nextDouble() * (2 * pi);
    });
  }

//
  void onTapDown(TapDownDetails tap) {
    // El usuario presionó el botón. Esto puede ser un toque o una retención.
    if (likeOutETA != null) {
      likeOutETA.cancel(); // ¡No queremos que la puntuación desaparezca!
    }
    if (_likeWidgetStatus == LikeWidgetStatus.BECOMING_INVISIBLE) {
      // Hicimos tapping mientras el widget estaba volando. Necesito cancelar esa animación.
      likeOutAnimationController.stop(canceled: true);
      _likeWidgetStatus = LikeWidgetStatus.VISIBLE;
    } else if (_likeWidgetStatus == LikeWidgetStatus.HIDDEN) {
      _likeWidgetStatus = LikeWidgetStatus.BECOMING_VISIBLE;
      likeInAnimationController.forward(from: 0.0);
    }
    increment(null); // Cuida el grifo
    holdTimer =
        Timer.periodic(mainDuration, increment); // Se encarga de mantener
  }

  void onTapUp(TapUpDetails tap) {
    // El usuario quitó su dedo del botón.
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
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fsprinkle.png?alt=media&token=142e8666-03e2-479f-8b8b-19b7531ab241",
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
          child: ImageIcon(
              NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fheart.png?alt=media&token=5db2c9ae-2875-4c32-910c-53bc6315821f"),
              color: Colors.white,
              //color: Color(0xff721385),
              size: 40.0));
    } else {
      imageIcon = Padding(
          padding: EdgeInsets.all(2),
          child: ImageIcon(
              NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fheart_filled.png?alt=media&token=cf2b9db9-24da-4f01-826a-d44a724025c9"),
              color: Colors.white,
              //color: Color(0xff721385),
              size: 40.0));
    }
    return imageIcon;
  }
}
