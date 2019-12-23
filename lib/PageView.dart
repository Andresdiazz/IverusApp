import 'package:flutter/material.dart';

import 'Animated/Share.dart';
import 'Animated/heart.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
        body: PageView(
            scrollDirection: Axis.vertical,
            //controller: ctrl,
            children: [
              Container(
                child: Stack(
                  children: <Widget>[

                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/gif_videos_donal%2Fdonal_10.gif?alt=media&token=729c7ee4-47cb-46a5-a0d7-466c53c98945"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    Container(
                        alignment: Alignment.bottomRight,
                        //padding: EdgeInsets.only(top: 400),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            children: <Widget>[
                              AnimatedLikeButton(),
                              SizedBox(width: 10.0,),
                              AnimatedShareButton(),
                              SizedBox(width: 10.0,),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[

                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/IVERUS%2Fwhereslugo-lBVOaVl4yy8-unsplash.jpg?alt=media&token=781e40fd-6ebf-4fb4-81e2-6fb68dcc0666"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 350.0, top: 600),
                    child: Column(
                      children: <Widget>[
                        AnimatedLikeButton(),
                        SizedBox(width: 10.0,),
                        AnimatedShareButton(),
                        SizedBox(width: 10.0,),
                      ],
                    ),
                  )
                ],
              ),
              Stack(
                children: <Widget>[

                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/img_vertical%2FIMG_5468.JPG?alt=media&token=d25ff1a4-5643-408a-ac79-5e61057cdb80"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 350.0, top: 600),
                    child: Column(
                      children: <Widget>[
                        AnimatedLikeButton(),
                        SizedBox(width: 10.0,),
                        AnimatedShareButton(),
                        SizedBox(width: 10.0,),
                      ],
                    ),
                  )
                ],
              ),
              Stack(
                children: <Widget>[

                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/img_vertical%2FIMG_5469.JPG?alt=media&token=44f937ca-cae8-4ec1-8ae7-53b32f54638d"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 350.0, top: 600),
                    child: Column(
                      children: <Widget>[
                        AnimatedLikeButton(),
                        SizedBox(width: 10.0,),
                        AnimatedShareButton(),
                        SizedBox(width: 10.0,),
                      ],
                    ),
                  )
                ],
              ),
            ]
        )

    
    );

  }
}



