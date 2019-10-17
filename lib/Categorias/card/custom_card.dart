import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flare_dart/actor.dart';

import 'image_page.dart';

class CustomCard extends StatefulWidget {
  CustomCard({
  this.documentData,
    this.bloc,
    this.onPressed,
  });
  final CategoryItem documentData;
  final CategoriesBloc bloc;
  final VoidCallback onPressed;
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  var _opacity = 0.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Stack(
        children: <Widget>[
          Container(
            child: (widget.documentData.image != null)
                ? CachedNetworkImage(
                      imageUrl: widget.documentData.image,
                      fit: BoxFit.cover,
                  ) : null,
            width: double.infinity,
            height: double.infinity,
          ),
          InkWell(
            onDoubleTap: () {
              Timer(Duration(milliseconds: 1), () {
                setState(() {
                  _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                  print('aparece');
                });
              });
              Timer(Duration(seconds: 1), () {
                setState(() {
                  _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                  print('aparece');
                });
              });
            }
            ,
            onTap: widget.onPressed,
            child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: 60),
            child: FlareActor("assets/Like heart.flr", animation: "Like heart",),
            )
          ),
        ],
      ),
    );
  }

  BoxDecoration _whiteGradientDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.black, const Color(0x10000000)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter),
    );
  }
}
