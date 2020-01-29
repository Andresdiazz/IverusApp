import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocreacion/Ideas/ui/screens/timer.dart';
import 'package:cocreacion/Ideas/ui/widgets/sliding_cards.dart';
import 'package:cocreacion/Ideas/ui/widgets/tabs.dart';
import 'package:cocreacion/Users/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'exhibition_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      bloc: HomeBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Header(),
                      CountDownTimer(),
                    ],
                  ),
                  SizedBox(height: 40),
                  Tabs(),
                  SizedBox(height: 20),
                  SlidingCardsView(),
                ],
              ),
            ),
            ExhibitionBottomSheet(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: CachedNetworkImage(
          imageUrl: "https://firebasestorage.googleapis.com/v0/b/cocreacion-f17df.appspot.com/o/Assets%2Fimg%2FLOGO-IVERUS-NEGRO.png?alt=media&token=af898df2-cd8d-44f8-bc83-864000bab447",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          width: 150,
        )
        /*Text(
        'Iverus',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),*/
        );
  }
}
