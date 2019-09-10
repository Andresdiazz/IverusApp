import 'package:cocreacion/EditProfile/ui/widgets/edit_profile_header.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[EditProfileHeader(), image, edit],
      ),
    );
  }

  var image = Container(
    height: 300,
    child: Align(
      alignment: Alignment(0, 1),
      child: Card(
        child: CircleAvatar(
          maxRadius: 80,
          backgroundImage: AssetImage("assets/img/bienestar.jpg"),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        elevation: 8,
      ),
    ),
  );
  var edit = Container(
    height: 100,
    margin: const EdgeInsets.all(32),
    child: Align(
      child: Icon(
        Icons.edit,
        color: Colors.white,
      ),
      alignment: Alignment(1, -1),
    ),
  );
}
