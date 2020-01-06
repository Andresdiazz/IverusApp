import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'Animated/Share.dart';
import 'Animated/heart.dart';
import 'Categorias/model/category_item.dart';
import 'PageView.dart';
import 'insta_tree/insta_home.dart';
import 'insta_trivia/insta_home.dart';

void main() => runApp(VideoApp());

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  PageController controller_page = PageController();
  CategoriesBloc _bloc = CategoriesBloc("iverus_video");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: _bloc.categories,
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoryItem>> snapshot) {
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
                    children: <Widget>[
                      VideoView(
                        documentData: item,
                        bloc: _bloc,
                      )
                    ],
                  );
                },
              );
            }));
  }
}

class VideoView extends StatefulWidget {
  final CategoryItem documentData;
  final CategoriesBloc bloc;

  VideoView({this.documentData, this.bloc});

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController _controller;
  PageController controllerPage = PageController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.documentData.video)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

    controllerPage.addListener(() {
      setState(() {
        _controller.pause();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final topBar = new AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      flexibleSpace: Container(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AnimatedLikeButton(
              documentData: widget.documentData,
              bloc: widget.bloc,
            ),
            SizedBox(
              width: 10.0,
            ),
            AnimatedShareButton(
                documentData: widget.documentData, bloc: widget.bloc),
            SizedBox(
              width: 10.0,
            )
          ],
        ),
      ),
      elevation: 1.0,
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
                            fontFamily: 'Aileron', color: Colors.white),
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

    return PageView(
      controller: controllerPage,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 720.0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: _controller.value.initialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
              ),
            ),
            topBar
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
