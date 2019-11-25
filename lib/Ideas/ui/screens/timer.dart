import 'package:cocreacion/Ideas/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimer createState() => _CountDownTimer();
}

class _CountDownTimer extends State<CountDownTimer> {
  TimerBloc timerBloc;

  @override
  void initState() {
    super.initState();
    timerBloc = TimerBloc(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: timerBloc.timer,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Text(
            snapshot.data == null ? "" : snapshot.data.toString(),
            style:
                Theme.of(context).textTheme.body1.copyWith(color: Colors.black),
          );
        });
  }
}
