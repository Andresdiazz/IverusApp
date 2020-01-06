import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:cocreacion/Categorias/model/category_item.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import 'Animated/Share.dart';
import 'Animated/heart.dart';
import 'PageVideoView.dart';
import 'insta_tree/insta_home.dart';
import 'insta_trivia/insta_home.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoriesBloc _bloc = CategoriesBloc("iverus");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topBar = new AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 1.0,
      title: SizedBox(
          height: 25.0,
          child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2FLOGO-IVERUS-NEGRO.png?alt=media&token=af898df2-cd8d-44f8-bc83-864000bab447")),
      actions: <Widget>[
        /*Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.send, color: Colors.black),
        )*/
      ],
    );

    return Scaffold(
        //appBar: topBar,
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

    final topBar = new AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 1.0,
      flexibleSpace: Container(
          //color: Colors.grey,
          alignment: Alignment.bottomRight,
          //padding: EdgeInsets.only(top: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              AnimatedLikeButton(
                  documentData: widget.documentData, bloc: widget.bloc),
              SizedBox(
                width: 10.0,
              ),
              AnimatedShareButton(
                  documentData: widget.documentData, bloc: widget.bloc),
              SizedBox(
                width: 10.0,
              ),
            ],
          )),
      automaticallyImplyLeading: false,
      title: SizedBox(
          height: 25.0,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                },
                child: Container(
                    height: size.height * 2,
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 0.5, color: Colors.white),
                            right:
                                BorderSide(width: 0.5, color: Colors.white))),
                    child: Center(
                      child: Text(
                        "Picture",
                        style: TextStyle(
                          fontFamily: 'AileronBold',
                          color: Colors.white,
                          //decoration: TextDecoration.underline
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoApp()),
                  );
                },
                child: Container(
                    height: size.height * 2,
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border(
                            //left: BorderSide(width: 0.5, color: Colors.white),
                            right:
                                BorderSide(width: 0.5, color: Colors.white))),
                    child: Center(
                      child: Text(
                        "Video",
                        style: TextStyle(
                            fontFamily: 'Aileron', color: Colors.white),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InstHome_trivia()),
                  );
                },
                child: Container(
                    height: size.height * 2,
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border(
                            //left: BorderSide(width: 1.0, color: Colors.white),
                            right:
                                BorderSide(width: 0.5, color: Colors.white))),
                    child: Center(
                      child: Text(
                        "Trivia",
                        style: TextStyle(
                            fontFamily: 'Aileron', color: Colors.white),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InstHome_tree()),
                  );
                },
                child: Container(
                    height: size.height * 2,
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border(
                            //left: BorderSide(width: 1.0, color: Colors.white),
                            right:
                                BorderSide(width: 0.5, color: Colors.white))),
                    child: Center(
                      child: Text(
                        "Tree",
                        style: TextStyle(
                            fontFamily: 'Aileron', color: Colors.white),
                      ),
                    )),
              ),
            ],
          )),
      actions: <Widget>[
        /*Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.send, color: Colors.black),
        )*/
      ],
    );

    return PageView(scrollDirection: Axis.vertical,
        //controller: ctrl,
        children: [
          Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.documentData.image),
                        fit: BoxFit.cover)),
              ),
              topBar,
            ],
          ),
        ]);
  }
}
