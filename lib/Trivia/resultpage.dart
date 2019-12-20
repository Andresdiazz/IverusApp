import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:cocreacion/Evaluar_contenido/evaluar.dart';
import 'package:cocreacion/Ideas/ui/screens/home_page.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide_info.dart';
import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class resultpage extends StatefulWidget {
  int marks;
  final CategoryItem documentData;
  final CategoriesBloc categoriesBloc;
  final String table;

  resultpage(
      {Key key,
      @required this.marks,
      @required this.categoriesBloc,
      this.documentData,
      this.table})
      : super(key: key);

  @override
  _resultpageState createState() => _resultpageState(marks);
}

class _resultpageState extends State<resultpage> {
  List<String> images = [
    "images/success.png",
    "images/good.png",
    "images/bad.png",
  ];

  String message;
  String image;

  @override
  void initState() {
    if (marks < 20) {
      image = images[2];
      message =
          "Deberías esforzarte mucho ...\n" + "obtuvo una puntuación $marks";
    } else if (marks < 35) {
      image = images[1];
      message = "Puedes hacerlo mejor..\n" + "obtuvo una puntuación $marks";
    } else {
      image = images[0];
      message = "Lo hiciste muy bien..\n" + "obtuvo una puntuación  $marks";
    }
    super.initState();
  }

  int marks;

  _resultpageState(this.marks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Resultado",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Center(
                          child: Text(
                            message,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Quando",
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    widget.categoriesBloc.updateTriviaPoints(marks);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Evaluar(documentData: widget.documentData,),
                    ));
                  },
                  child: Text(
                    "Continua",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                ),
                AnimatedLikeButton(
                  categoriesBloc: this.widget.categoriesBloc,
                  documentData: widget.documentData,
                  table: widget.table,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AnimatedLikeButton extends StatefulWidget {
  final CategoryItem documentData;
  final CategoriesBloc categoriesBloc;
  final String table;

  AnimatedLikeButton(
      {Key key, this.categoriesBloc, this.documentData, this.table})
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
    _counter = widget.categoriesBloc.getLikes(widget.documentData.id);

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
