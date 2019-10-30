import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/card/custom_card.dart';
import 'package:cocreacion/Categorias/card/image_page.dart';
import 'package:cocreacion/Categorias/card/video_page.dart';
import 'package:cocreacion/Trivia/quizpage.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../tree/intro/intro.dart';

class Iverus extends StatefulWidget {
  @override
  _IverusState createState() => _IverusState();
}

class _IverusState extends State<Iverus> {
  List<PreloadPageController> controllers = [];
  CategoriesBloc _bloc = CategoriesBloc("iverus");
  final _db = Firestore.instance;
  var _opacity = 0.0;
  var tipo = 'iverus';
  @override
  void initState() {
    _loadImage();
    controllers = [
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
    ];
    super.initState();
  }

  _animatePage(int page, int index) {
    for (int i = 0; i < 5; i++) {
      if (i != index) {
        controllers[i].animateToPage(page,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
  }

  _loadImage() async {
    int size = 0;
    return await _db.collection('iverus').getDocuments().then((snap) {
      size = size + snap.documents.length;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        body: PreloadPageView.builder(
          controller:
              PreloadPageController(viewportFraction: 0.7, initialPage: 3),
          itemCount: 5,
          preloadPagesCount: 5,
          itemBuilder: (context, mainIndex) {
            return PreloadPageView.builder(
              itemCount: 5,
              preloadPagesCount: 5,
              controller: controllers[mainIndex],
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              onPageChanged: (page) {
                _animatePage(page, mainIndex);
              },
              itemBuilder: (context, index) {
                var hitIndex = (mainIndex * 5) + index;
                var hit;
                if (_bloc.items != null) {
                  hit = _bloc.items[hitIndex];
                }
                return GestureDetector(
                    onTap: () {
                      if (_bloc.items != null) {
                        if (hit.tree == 'yes') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Intro( documentData: hit,),
                            ),
                          );
                          print('video ');
                        }
                        else if (hit.trivia == 'yes') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => getjson( hit.name),
                            ),
                          );
                          print('video ');
                        }else if (hit.video != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPage(
                                  documentData: hit,
                                  categoriesBloc: _bloc,
                                  table: tipo),
                            ),
                          );
                          print('video ');
                        } else if (hit.image != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImagePage(
                                documentData: hit,
                                categoriesBloc: _bloc,
                                table: tipo,
                              ),
                            ),
                          );
                          print('imagen ');
                        }
                      }
                    },
                  child: CustomCard(
                    documentData: hit,
                    bloc: _bloc,
                    onPressed: (){
                      if (_bloc.items != null) {
                        if (hit.tree == 'yes') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Intro( documentData: hit,),
                            ),
                          );
                          print('video ');
                        }
                        else if (hit.trivia == 'yes') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => getjson( hit.name),
                            ),
                          );
                          print('video ');
                        }else if (hit.video != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPage(
                                  documentData: hit,
                                  categoriesBloc: _bloc,
                                  table: tipo),
                            ),
                          );
                          print('video ');
                        } else if (hit.image != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImagePage(
                                documentData: hit,
                                categoriesBloc: _bloc,
                                table: tipo,
                              ),
                            ),
                          );
                          print('imagen ');
                        }
                      }
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
