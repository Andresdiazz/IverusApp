import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Animated/Share.dart';
import 'package:cocreacion/Animated/heart.dart';
import 'package:cocreacion/tree/intro/intro.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_stories/flutter_stories.dart';
import 'bloc/categories_bloc.dart';
import 'model/category_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Belleza extends StatefulWidget {
  @override
  _BellezaState createState() => _BellezaState();
}

class _BellezaState extends State<Belleza> {
  var product_list;
  CategoriesBloc _bloc = CategoriesBloc("belleza");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BEAUTY',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "Aileron",
              letterSpacing: 8),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: _bloc.categories,
        builder:
            (BuildContext context, AsyncSnapshot<List<CategoryItem>> snapshot) {
          if (!snapshot.hasData) {
            return Text("loading....");
          }
          int length = snapshot.data.length;
          return StaggeredGridView.countBuilder(
              itemCount: length,
              crossAxisCount: 4,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              itemBuilder: (_, int index) {
                final CategoryItem item = snapshot.data[index];
                return Stack(
                  children: <Widget>[
                    Single_prod(item,
                      _bloc,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 120.0),
                        child: AnimationHeart(item,_bloc)
                    )
                  ],
                );
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(2));
        },
      ),
    );
  }
}




class AnimationHeart extends StatefulWidget {
  @override
  final CategoryItem documentData;
  final CategoriesBloc bloc;


  AnimationHeart(this.documentData, this.bloc) {}


  _AnimationHeartState createState() => _AnimationHeartState();
}

var _opacity = 0.0;
var _lik= 0.0;
var _animated ="";
var _animatedSmall="";
class _AnimationHeartState extends State<AnimationHeart> {
  @override
  Widget build(BuildContext context) {
    return InkWell(

      // Corazon Grande
        onDoubleTap: (){
          Timer(Duration(milliseconds:1 ),(){
            setState(() {
              _opacity = _opacity == 0.0 ? 1.0 : 0.0;
              _animated ="tito";

              print('aparece');
            });
          });
          Timer(Duration(seconds:1 ),(){
            setState(() {
              _opacity = _opacity == 0.0 ? 1.0 : 0.0;
              _animated ="";

              print('aparece');
            });
          });
        },
        onTap: () {
          widget.bloc.itemController.sink.add(widget.documentData);
          if (widget.documentData.video != null) widget.bloc.videoClick();

          showCupertinoDialog(
            context: context,
            builder: (context) {
              return GestureDetector(
                  child: Scaffold(
                    body: Stack(
                      children: <Widget>[

                        Story(
                          onFlashForward: Navigator.of(context).pop,
                          onFlashBack: Navigator.of(context).pop,
                          momentCount: 1,
                          momentDurationGetter: (idx) => Duration(seconds: 90),
                          momentBuilder: (context, idx) {

                            if (widget.documentData.video != null) {
                              print('lo logre cabron');
                              return InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Intro()));

                                },
                              );

                            } else {
                              print('pinche wey lo lograstes');
                              return Container(
                                child: Image.network(widget.documentData.image),
                              );
                            }
                          },
                        ),
                        AnimatedLikeButton(),
                        AnimatedShareButton()


                      ],
                    ),
                  ));
            },
          );
          print(widget.documentData);
        },
        child: Container(
            margin: EdgeInsets.only(left:20.0,top: 0.0,right: 0.0),
            width: 150.0,
            height: 150.0,
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 1),
              child: FlareActor(
                "assets/img/Favourite.flr",
                animation: _animated,
                fit: BoxFit.contain,
              ), )
        )
    );
  }
}

class Single_prod extends StatelessWidget {
  final CategoryItem documentData;
  final CategoriesBloc bloc;

  Single_prod(this.documentData, this.bloc) {}

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: CachedNetworkImage(
        imageUrl: documentData.image,
        fit: BoxFit.contain,
      )

      /*Image.network(
        documentData.image,
        fit: BoxFit.cover,
      ),*/
    );
  }
}
