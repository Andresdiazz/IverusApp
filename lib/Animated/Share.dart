import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
class AnimatedShareButton extends StatefulWidget {
  AnimatedShareButton({Key key }) : super(key: key);

  @override
  _AnimatedShareButtonState createState() => _AnimatedShareButtonState();
}


class _AnimatedShareButtonState extends State<AnimatedShareButton> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 300.0,top:700.0),
        child: Stack(
          alignment: FractionalOffset.center,
          overflow: Overflow.visible,
          children: <Widget>[
            getLikeButton(),
          ],
        ));
  }

  Widget getLikeButton() {
    var extraSize = 0.0;

    return GestureDetector(
       onTap: (){
         //_shareImageAndText();
         _shareImage();
       },
        child: Container(
          height: 60.0 + extraSize,
          width: 60.0 + extraSize,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xff23A8C5), width: 1.0),
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Color(0xff23A8C5), blurRadius: 8.0)]),
          child: getHeartIcon(),
        ));
  }





//






  Widget getHeartIcon() {
    return Icon(
      Icons.share
    );
  }


  void _shareImageAndText() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/img/excited.png');
      await WcFlutterShare.share(
          sharePopupTitle: 'share',
          subject: 'This is subject',
          text: 'This is text',
          fileName: 'share.png',
          mimeType: 'assets/img/excited.png',
          bytesOfFile: bytes.buffer.asUint8List());
    } catch (e) {
      print('error: $e');
    }



}
  void _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/img/excited.png');
      await WcFlutterShare.share(
          sharePopupTitle: 'share',
          fileName: 'excited.png',
          mimeType: 'assets/img/excited.png',
          bytesOfFile: bytes.buffer.asUint8List());
    } catch (e) {
      print('error: $e');
    }
  }

}



