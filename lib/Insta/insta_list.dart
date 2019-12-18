import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class InstaList extends StatefulWidget {
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {

  CategoriesBloc _bloc = CategoriesBloc("iverus");
  final _db = Firestore.instance;

  @override
  void initState() {


    super.initState();
  }



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
                ],
              );
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(4));
      },

    );

  /*  return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => index == 0 ? new SizedBox() : Column(
        //cards
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          //2st Row
          Single_prod( ,
            _bloc,
          )
          //3rd row
          /*
             Padding(
               padding: const EdgeInsets.all(5.0),
               child: Stack(
                 children: <Widget>[
                   Row(
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
             */


          //5th row
          /*Padding(
               padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
               child: Row(
                mainAxisAlignment:MainAxisAlignment.start,
                 children: <Widget>[
                   Container(
                     height: 40.0,
                     width: 40.0,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         fit: BoxFit.fill,
                         image: NetworkImage(
                           "https://scontent-qro1-1.xx.fbcdn.net/v/t1.0-9/70280246_138757747339462_127735759061909504_n.jpg?_nc_cat=107&_nc_ohc=8eJcklJktlMAQl72cdt8gxgLQ8e_rK6Apvcdy2OZSQZNSVsEXRL4ba-ug&_nc_ht=scontent-qro1-1.xx&oh=9255b3e83b91f9fb913469c4a77a444e&oe=5E6C418D"
                         ),
                       ),
                     ),
                   ),
                   SizedBox(width: 10.0,),
                   Expanded(
                     child: TextField(
                       decoration: InputDecoration(
                         border: InputBorder.none,
                         hintText: "Add a comment... ",
                       ),
                     ),
                   )
                 ],
               ),
             ),*/


        ],
      ),
    );*/
  }


}

class Single_prod extends StatelessWidget {
  final CategoryItem documentData;
  final CategoriesBloc bloc;

  Single_prod(this.documentData, this.bloc) {}

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: documentData.image != null ? Image.network(
        documentData.image,
        fit: BoxFit.contain,
    ): Container());
  }
}
