
import 'package:cocreacion/insta_tree/insta_home.dart';
import 'package:cocreacion/insta_trivia/insta_body.dart';
import 'package:flutter/material.dart';

import '../PageVideoView.dart';
import '../PageView.dart';

class InstHome_trivia extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    final topBar = new AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 1.0,
      automaticallyImplyLeading: false,
      title: SizedBox(
          height: 25.0,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                },
                child: Container(
                    height: size.height * 2 ,
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 0.5, color: Colors.white),
                            right: BorderSide(width: 0.5, color: Colors.white)
                        )
                    ),
                    child: Center(
                      child: Text("Picture", style: TextStyle(
                          fontFamily: 'Aileron',
                          color: Colors.white
                      ),),
                    )
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoApp()),
                  );
                },
                child: Container(
                    height: size.height * 2 ,
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border(
                            //left: BorderSide(width: 1.0, color: Colors.white),
                            right: BorderSide(width: 0.5, color: Colors.white)
                        )
                    ),
                    child: Center(
                      child: Text("Video", style: TextStyle(
                          fontFamily: 'Aileron',
                          color: Colors.white
                      ),),
                    )
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InstHome_trivia()),
                  );
                },
                child: Container(
                    height: size.height * 2 ,
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border(
                            //left: BorderSide(width: 1.0, color: Colors.white),
                            right: BorderSide(width: 0.5, color: Colors.white)
                        )
                    ),
                    child: Center(
                      child: Text("Trivia", style: TextStyle(
                          fontFamily: 'AileronBold',
                          color: Colors.white,
                          //decoration: TextDecoration.underline
                      ),),
                    )
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InstHome_tree()),
                  );
                },
                child: Container(
                    height: size.height * 2 ,
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border(
                            //left: BorderSide(width: 1.0, color: Colors.white),
                            right: BorderSide(width: 0.5, color: Colors.white)
                        )
                    ),
                    child: Center(
                      child: Text("Tree", style: TextStyle(
                          fontFamily: 'Aileron',
                          color: Colors.white
                      ),),
                    )
                ),
              ),
            ],
          )
      ),
      actions: <Widget>[
        /*Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Icon(Icons.send, color: Colors.black),
        )*/
      ],
    );

    return Scaffold(
          body: Stack(
            children: <Widget>[
              InstaBody_trivia(),
              topBar
            ],
          ),
    );
  }
}