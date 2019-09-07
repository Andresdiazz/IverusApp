import 'package:cocreacion/Ideas/ui/widgets/sliding_cards.dart';
import 'package:cocreacion/Ideas/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';

import 'exhibition_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8),
                Header(),
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
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Image(
          image: AssetImage("assets/img/iverus.png"),
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
