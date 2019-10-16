import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../widget/custom_card.dart';
import 'image_page.dart';

class GridNew extends StatefulWidget {

  @override



  _GridNewState createState() => _GridNewState();
}

class _GridNewState extends State<GridNew> {
  List<PreloadPageController> controllers = [];
  CategoriesBloc _bloc = CategoriesBloc("belleza");
  final _db = Firestore.instance;

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

  _loadImage() async{
    int size = 0;
    return await  _db.collection('belleza').getDocuments().then((snap) {
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
                if ( _bloc.items != null) {
                  hit = _bloc.items[hitIndex];
                }
                return GestureDetector(
                  onTap: () {
                    if (_bloc.items != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImagePage(documentData: hit,),
                        ),
                      );
                    }
                  },
                  child: CustomCard(
                    // title: hit?.user,
                    // description: hit?.tags,
                    documentData: hit,
                    bloc: _bloc,
                  ),
                );
              },
            );
          },
        )
    );
  }
}
