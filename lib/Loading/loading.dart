import 'package:flutter/material.dart';
import 'package:loading/loading.dart';

import 'Indicator/bull_loading.dart';

class ShowLoading extends StatelessWidget {

  var a = 1 ;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(


      body: Container(
        color: Colors.black,
        child: Center(

          child: a == 1 ?  Loading(indicator: BallPulseIndicator(), size: 200.0 ): null
        ),
      ),



    );
  }
}