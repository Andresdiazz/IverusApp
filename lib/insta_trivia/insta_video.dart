import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:cocreacion/Trivia/quizpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animations/loading_animations.dart';

class InstaList_trivia extends StatefulWidget {
  @override
  _InstaList_triviaState createState() => _InstaList_triviaState();
}

class _InstaList_triviaState extends State<InstaList_trivia> {

  CategoriesBloc _bloc = CategoriesBloc("iverus_trivia");


  @override
  Widget build(BuildContext context) {

    return  StreamBuilder(
      stream: _bloc.categories,
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryItem>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child:LoadingFadingLine.circle(
              borderColor: Colors.blueGrey,
              borderSize: 3.0,
              size: 90.0,
              backgroundColor: Colors.blueGrey,
              duration: Duration(milliseconds: 500),
            ) ,
          );
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

  }


}

class Single_prod extends StatelessWidget {
  final CategoryItem documentData;
  final CategoriesBloc bloc;
  var tipo = 'iverus_trivia';


  Single_prod(this.documentData, this.bloc) {}

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return GridTile(
        child: InkWell(
            child:documentData.image != null ? Image.network(
              documentData.image,
              fit: BoxFit.contain,
              width: deviceSize.width,
            ): Container(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => getjson(
                    documentData.name,
                    documentData.punto,
                    documentData.ask,
                    documentData,
                    bloc,
                    tipo,
                  ),
                ),
              );
            })
    );
  }
}

