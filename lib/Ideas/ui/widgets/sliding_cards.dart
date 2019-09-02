import 'package:cocreacion/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.60,
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            name: 'Moda',
            date: 'Live Tomorrow 7PM',
            assetName: 'img/gif.gif',
            offset: pageOffset,
            //videoPlayerController: VideoPlayerController.asset('img/video_prueba.mp4'),
          ),
          SlidingCard(
            name: 'Bienestar',
            date: 'Live Monday 8PM',
            assetName: 'img/bienestar.gif',
            offset: pageOffset - 1,
          ),
          SlidingCard(
            name: 'Cuidado Personal',
            date: 'Live Today 8PM',
            assetName: 'img/moda.gif',
            offset: pageOffset - 1,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String assetName;
  final double offset;


  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 30),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'assets/$assetName',
                height: MediaQuery.of(context).size.height * 0.46,
                alignment: Alignment(-offset.abs(), 1),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 1),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;

  const CardContent(
      {Key key,
      @required this.name,
      @required this.date,
      @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(8 * offset, 0),
                    child: Text(name,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 8),
                  Transform.translate(
                    offset: Offset(32 * offset, 0),
                    child: Text(
                      date,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Lato",
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ]
            ),
            Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  splashColor: Colors.amber,
                  color: Colors.cyan,
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: Text('More'),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Example08())
                    );
                  },
                ),
              ),
          ],
        )
        );
  }
}
