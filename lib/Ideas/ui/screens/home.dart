import 'package:cocreacion/Ideas/ui/widgets/category_card_list.dart';
import 'package:cocreacion/Ideas/ui/widgets/floating_button.dart';
import 'package:cocreacion/Ideas/ui/widgets/gradient_back.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide_info.dart';
import 'package:cocreacion/Ideas/ui/widgets/text_bar.dart';
import 'package:cocreacion/Users/bloc/bloc_user.dart';
import 'package:cocreacion/Users/bloc/home_bloc.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/ui/widgets/button_profile.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class Home extends StatelessWidget {
  User user;

  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40.0),
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    GradientBack(),
                    CategoryCardList(),
                  ],
                ),
                SlideList(user),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 650.0, left: 320.0),
            child: FloatingButton(),
          ),
          Container(
            height: 90.0,
            width: 450.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.grey],
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 0.6),
              stops: [0.0, 0.6],
              tileMode: TileMode.clamp,
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextBar(),
                ButtonProfile(
                    user: user, homeBloc: BlocProvider.of<HomeBloc>(context))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
