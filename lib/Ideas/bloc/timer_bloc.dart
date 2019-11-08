import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Ideas/ui/widgets/rank_dioalog.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:countdown/countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../CommonResponse.dart';
import '../../SharedPref.dart';

class TimerBloc extends Bloc {
  final _cloudFiretoreRepository = CloudFirestoreRepository();
  CountDown _cd;
  final timerController = BehaviorSubject<String>();
  final BuildContext context;
  Observable<String> get timer => timerController.stream;
  String _resultDate = "2019-11-07 20:11:00";
  final DateFormat _df = DateFormat('yyyy-MM-dd HH:mm:ss');

  TimerBloc(this.context) {
    int second = _df.parse(_resultDate).difference(DateTime.now()).inSeconds;
//    second = second.abs();

    if (second > 0) {
      scheduleNotification(second);
      _cd = CountDown(Duration(seconds: second));
      var sub = _cd.stream.listen(null);

      sub.onData((Duration d) {
        int seconds = d.inSeconds;
        int days = seconds ~/ (24 * 3600);
        seconds = seconds % (24 * 3600);
        int hour = seconds ~/ 3600;

        seconds %= 3600;
        int minutes = seconds ~/ 60;
        seconds %= 60;

        timerController.add('$days:$hour:$minutes:$seconds');
      });

      sub.onDone(() {
        getRankAndShowDialog();
      });
    } else {
      timerController.add('');
    }
  }

  initTime() {}

  getRankAndShowDialog() {
    _cloudFiretoreRepository.getRank().then((data) {
      if (data.code == CommonResponse.successCode) {
        var users = data.data as List<DocumentSnapshot>;
        List<User> usersList = List();
        users.forEach((user) {
          usersList.add(User.fromJson(user.data));
        });

        SharedPref().get(SharedPref.user).then((user) {
          User userObj = User.stringToObject(user);
          int index = usersList.indexWhere((users) => users.uid == userObj.uid);

          if (index == 0)
            RankDialog().showCongoRankDialog(context);
          else
            RankDialog().showRankDialog(context, index + 1);
        });
      }
    }).catchError((error) {});
  }

// Notification part
  scheduleNotification(int seconds) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('drawable/iverus');

    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    // initialisation complete

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var scheduledNotificationDateTime =
        new DateTime.now().add(new Duration(seconds: seconds));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'Rank123',
      'Rank',
      'Rank Notification',
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.cancel(8);

    await flutterLocalNotificationsPlugin.schedule(
        8,
        'Results are here',
        'Tap to see your Rank',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  get onDidReceiveLocalNotification => () {
        getRankAndShowDialog();
      };

  get onSelectNotification => () {
        getRankAndShowDialog();
      };

  @override
  void dispose() {}
}
