import 'package:cocreacion/Categorias/Beauty.dart';
import 'package:cocreacion/Categorias/Fashion.dart';
import 'package:cocreacion/Categorias/Iverus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

//import 'package:chewie/chewie.dart';
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
            name: "I'm Iverus",
            date: 'Live Tomorrow 7PM',
            assetName: 'https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fiverus.gif?alt=media&token=dd13f1bd-f1d2-4cb4-a173-09bd2bdee0c1',
            offset: pageOffset,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Iverus()));
            },

            //videoPlayerController: VideoPlayerController.asset('img/video_prueba.mp4'),
          ),
          /*SlidingCard(
            name: 'Fashion',
            date: 'Live Tomorrow 7PM',
            assetName: 'https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fgif.gif?alt=media&token=b6c5a543-22c3-435c-ab59-29e352d02736',
            offset: pageOffset - 1,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fashion()));
            },

            //videoPlayerController: VideoPlayerController.asset('img/video_prueba.mp4'),
          ),
          SlidingCard(
            name: 'Beauty',
            date: 'Live Monday 8PM',
            assetName: 'https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2Fbeauty.gif?alt=media&token=be3e0e44-0ff5-49bc-a404-3eb21d157672',
            offset: pageOffset - 2,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Beauty(category: 'belleza',)));
            },
          ),*/
          /*SlidingCard(
            name: 'Personal Care',
            date: 'Live Today 8PM',
            assetName: 'img/moda.gif',
            offset: pageOffset - 3,
            onPressed: () {
             // Navigator.push(context,
               //   MaterialPageRoute(builder: (context) => Cpersonal()));
            },
          ),*/
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  String name;
  String date;
  String assetName;
  double offset;
  VoidCallback onPressed;

  SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
    @required this.onPressed,
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
              child: Image.network(
                '$assetName',
                height: MediaQuery.of(context).size.height * 0.45,
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
                onPressed: onPressed,
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
  final VoidCallback onPressed;

  CardContent(
      {Key key,
      @required this.name,
      @required this.date,
      @required this.offset,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final button = Transform.translate(
      offset: Offset(48 * offset, 0),
      child: RaisedButton(
        splashColor: Colors.amber,
        color: Colors.cyan,
        child: Transform.translate(
          offset: Offset(24 * offset, 0),
          child: Text(
            'More',
            style:
                TextStyle(fontFamily: "Aileron", fontWeight: FontWeight.w600),
          ),
        ),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        onPressed: onPressed,
      ),
    );

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
                            fontFamily: "AileronBold",
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 8),
                  Transform.translate(
                    offset: Offset(32 * offset, 0),
                    child: Text(
                      date,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Aileron",
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
            button
            /*Transform.translate(
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

                  },
                ),
              ),*/
          ],
        ));
  }
}
