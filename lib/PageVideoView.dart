import 'package:cocreacion/Categorias/bloc/categories_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'Animated/Share.dart';
import 'Animated/heart.dart';
import 'Categorias/model/category_item.dart';

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

    final topBar = new AppBar(
      backgroundColor: new Color(0xfff8faf8),
      centerTitle: true,
      elevation: 1.0,
      title: SizedBox(
          height: 25.0, child: Image.network("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2FLOGO-IVERUS-NEGRO.png?alt=media&token=af898df2-cd8d-44f8-bc83-864000bab447")),
      actions: <Widget>[
        /*Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.send, color: Colors.black),
        )*/
      ],
    );

    return Scaffold(
      appBar: topBar,
      body: StreamBuilder(
        stream: _bloc.categories,
        builder: (BuildContext context, AsyncSnapshot<List<CategoryItem>> snapshot){
          if (!snapshot.hasData) {
            print('Alberto:No se Encontro Datos');
            print('Alberto: Esta Cargando!!!');
            return Center(
              child:LoadingFadingLine.circle(
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
                 )],
              );
            },
          );
        }



    )
    );

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
    ..initialize().then((_){
        setState(() {
          _controller.play();
        });
    });

    controllerPage.addListener((){
        setState(() {

         _controller.pause();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  PageView(
      controller: controllerPage,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 720.0,
              child: InkWell(
                onTap: (){
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
                    :Container(),

              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AnimatedLikeButton(),
                  SizedBox(
                    width: 10.0,
                  ),
                  AnimatedShareButton(),
                  SizedBox(
                    width: 10.0,
                  )
                ],
              ),
            )
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


