import 'package:countdown/countdown.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class TimerBloc extends Bloc {
  CountDown cd = CountDown(Duration(days: 2));
  final timerController = BehaviorSubject<String>();

  Observable<String> get timer => timerController.stream;

  TimerBloc() {
    var sub = cd.stream.listen(null);

    sub.onData((Duration d) {
      timerController.add(d.toString());
      print(d);
    });

    sub.onDone(() {
      print("done");
    });
  }

  @override
  void dispose() {}
}
