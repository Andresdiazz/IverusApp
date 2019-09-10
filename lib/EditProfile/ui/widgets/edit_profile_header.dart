import 'package:flutter/material.dart';

class EditProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            new Container(
              height: 250.0,
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.
                      Colors.cyanAccent,
                      Colors.deepPurpleAccent,
                      Colors.deepPurple,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      clipper: BottomWaveClipper(),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
