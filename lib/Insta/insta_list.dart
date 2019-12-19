import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Animated/Share.dart';
import '../Animated/heart.dart';

class InstaList extends StatefulWidget {
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {

  CategoriesBloc _bloc = CategoriesBloc("iverus");

  @override
  Widget build(BuildContext context) {

    return  StreamBuilder(
      stream: _bloc.categories,
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryItem>> snapshot) {
        if (!snapshot.hasData) {
          return Text("loading....");
        }
        int length = snapshot.data.length;
        return StaggeredGridView.countBuilder(
            itemCount: length ,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 550, left: 320),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AnimatedLikeButton(),
                            SizedBox(width: 10.0,),
                            AnimatedShareButton(),
                            SizedBox(width: 10.0,),
                          ],
                        ),
                      ],
                    ),
                  ),


                ],
              );
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(4));
      },

    );
  }


}

class Single_prod extends StatelessWidget {
  final CategoryItem documentData;
  final CategoriesBloc bloc;

  Single_prod(this.documentData, this.bloc) {}

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return GridTile(
        child: documentData.image != null ? Image.network(
        documentData.image,
        fit: BoxFit.contain,
            width: deviceSize.width,

        ): Container());
  }
}

