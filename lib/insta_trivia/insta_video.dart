import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:cocreacion/Trivia/quizpage.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class InstaList_trivia extends StatefulWidget {
  @override
  _InstaList_triviaState createState() => _InstaList_triviaState();
}

class _InstaList_triviaState extends State<InstaList_trivia> {

  CategoriesBloc _bloc = CategoriesBloc("iverus_trivia");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: _bloc.categories,
          //print an integer every 2secs, 10 times
          builder:
              (BuildContext context, AsyncSnapshot<List<CategoryItem>> snapshot) {
            if (!snapshot.hasData) {
              print('Alberto:No se Encontro Datos');
              print('Alberto: Esta Cargando!!!');
              return Center(
                child: LoadingFadingLine.circle(
                  borderColor: Colors.blueGrey,
                  borderSize: 3.0,
                  size: 90.0,
                  backgroundColor: Colors.blueGrey,
                  duration: Duration(milliseconds: 500),
                ),
              );
            }
            int length = snapshot.data.length;
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: length,
              itemBuilder: (_, int index) {
                final CategoryItem item = snapshot.data[index];
                print('Alberto:Si se Encontro Datos!!');
                print(item);

                return Stack(
                  children: <Widget>[Single_prod(documentData: item, bloc: _bloc)],
                );
              },
            );
          },
        ));
  }

}


class Single_prod extends StatefulWidget {
  final CategoryItem documentData;
  final CategoriesBloc bloc;

  Single_prod({this.documentData, this.bloc});

  @override
  _Single_prodState createState() => _Single_prodState();
}

class _Single_prodState extends State<Single_prod> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return  PageView(scrollDirection: Axis.vertical,
         children: [
               InkWell(
                  child:widget.documentData.image != null ? Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.documentData.image,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: size.width,
                        height: size.height,
                      )
    ): Container(),
                   onTap: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => getjson(
                           widget.documentData.name,
                           widget.documentData.punto,
                           widget.documentData.ask,
                           widget.documentData,
                           widget.bloc,
                           widget.documentData.tipo,
                         ),
                       ),
                     );
                   })
            ]);
  }
}