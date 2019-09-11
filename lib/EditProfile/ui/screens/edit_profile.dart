import 'package:cocreacion/EditProfile/bloc/edit_profile_bloc.dart';
import 'package:cocreacion/EditProfile/ui/widgets/edit_profile_header.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileBloc _editProfileBloc = EditProfileBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(height: 250, child: EditProfileHeader()),
          ListView(
            children: <Widget>[
              getUpper(context),
              SizedBox(
                height: 40,
              ),
              getName(context),
              SizedBox(
                height: 20,
              ),
              getEmail(context),
              SizedBox(
                height: 20,
              ),
              getPhone(context),
              SizedBox(
                height: 20,
              ),
              getDesc(context)
            ],
          ),
        ],
      ),
    );
  }

  getUpper(context) {
    return Container(
      height: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/img/edit.png"),
                  width: 20,
                  color: Colors.deepPurple,
                ),
                Text(
                  "Edit Profile",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
          StreamBuilder<bool>(
            stream: _editProfileBloc.isEditing,
            builder: (context, snapshot) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Align(
                  alignment: Alignment(0, 1),
                  child: Stack(
                    alignment: Alignment(1, -1),
                    children: <Widget>[
                      Card(
                        child: CircleAvatar(
                          maxRadius: 60,
                          backgroundImage:
                              AssetImage("assets/img/bienestar.jpg"),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80)),
                        elevation: 8,
                      ),
                      snapshot.data == null || !snapshot.data
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 22,
                              ),
                            )
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.exit_to_app,
                  color: Colors.deepPurple,
                  size: 22,
                ),
                Text(
                  "Logout",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getName(context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: Colors.blueGrey,
                  width: 0.5,
                  style: BorderStyle.solid)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 22,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Name",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.grey),
                ),
                SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.body2,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  getEmail(context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: Colors.blueGrey,
                  width: 0.5,
                  style: BorderStyle.solid)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.blue,
                  size: 22,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Email",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.grey),
                ),
                SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.body2,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  getPhone(context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: Colors.blueGrey,
                  width: 0.5,
                  style: BorderStyle.solid)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.phone,
                  color: Colors.blue,
                  size: 22,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Phone",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.grey),
                ),
                SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.body2,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  getDesc(context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: Colors.blueGrey,
                  width: 0.5,
                  style: BorderStyle.solid)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.description,
                  color: Colors.blue,
                  size: 22,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "About you",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.grey),
                ),
                SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    minLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.body2,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
