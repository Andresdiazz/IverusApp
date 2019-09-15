import 'dart:math';
import 'dart:typed_data';
//import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_player/video_player.dart';

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

List<IntSize> _createSizes(int count) {
  Random rnd = new Random();
  return new List.generate(count,
      (i) => new IntSize((rnd.nextInt(500) + 200), rnd.nextInt(800) + 200));
}

class Example08 extends StatelessWidget {
  Example08() : _sizes = _createSizes(_kItemCount).toList();

  static const int _kItemCount = 1000;
  final List<IntSize> _sizes;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'MODA',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "Lato",
              letterSpacing: 8),
        ),
        backgroundColor: Colors.white,
      ),
      body: new StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemBuilder: (context, index) => new _Tile(index, _sizes[index]),
        staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
      ),
    );
  }
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.size);

  final IntSize size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              //new Center(child: new CircularProgressIndicator()),
              new Center(
                child: new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://picsum.photos/${size.width}/${size.height}/',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChewieDemo extends StatefulWidget {
  final IntSize size;
  final int index;
  const ChewieDemo(this.size, this.index);

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
//  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4/${widget.size.width}/${widget.size.height}/');
    _videoPlayerController2 = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');
//    _chewieController = ChewieController(
//      videoPlayerController: _videoPlayerController1,
//      aspectRatio: 3 / 2,
//      autoPlay: true,
//      looping: true,
//      // Try playing around with some of these other options:
//
//      // showControls: false,
//      // materialProgressColors: ChewieProgressColors(
//      //   playedColor: Colors.red,
//      //   handleColor: Colors.blue,
//      //   backgroundColor: Colors.grey,
//      //   bufferedColor: Colors.lightGreen,
//      // ),
//      // placeholder: Container(
//      //   color: Colors.grey,
//      // ),
//      // autoInitialize: true,
//    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
//    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
//            Expanded(
//              child: Center(
//                child: Chewie(
//                  controller: _chewieController,
//                ),
//              ),
//            ),
      ],
    ));
  }
}
