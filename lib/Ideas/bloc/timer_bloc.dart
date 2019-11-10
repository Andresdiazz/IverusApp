import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Ideas/model/result_model.dart';
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

//  String _resultDate = "2019-11-09 23:01:00";
  final DateFormat _df = DateFormat('yyyy-MM-dd HH:mm:ss');
  ResultModel resultModel;

  TimerBloc(this.context) {
    _cloudFiretoreRepository.getResultTime().then((value) {
      resultModel = ResultModel.fromJson(value.data);

      int second =
          _df.parse(resultModel.time).difference(DateTime.now()).inSeconds;
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

//          DateFormat dateFormat = DateFormat('dd:HH:mm:ss');
//          String date = "$days:$hour:$minutes:$seconds";
//
//          dateFormat.format(dateFormat.parse(date));
          timerController.add('$days:$hour:$minutes:$seconds');
        });

        sub.onDone(() {
          getRankAndShowDialog();
        });
      } else {
        timerController.add('');
      }
    });
  }

  getRankAndShowDialog() async {
    try {
      var result = await _cloudFiretoreRepository.getRank(resultModel.id);
      if (result.code == CommonResponse.successCode) {
        ResultModel resultModel = ResultModel.fromJson(result.data);
        if (resultModel.ranks == null || resultModel.ranks.length == 0) {
//          No one has opened the ranks yet. So put get points from all users and put them in ranks
          Map<String, int> points = await getUsersPoints();
          resultModel.ranks = points;
          _cloudFiretoreRepository.updateResults(
              resultModel.id, resultModel.getMap());
//          show dialog now
        } else {
          //            continue normally
          Map<String, int> points = await getUsersPoints();
          resultModel.ranks = points;
//          show dialog now
        }

        var user = await SharedPref().get(SharedPref.user);
        var userObj = User.stringToObject(user);
        userObj.points = 0;
        _cloudFiretoreRepository.updateUserDataFiretore(userObj);

        SharedPref().save(SharedPref.user, userObj.toString());

        int rank = resultModel.ranks.keys
            .toList()
            .indexWhere((value) => userObj.uid == value);

        if (rank == 0)
          RankDialog().showCongoRankDialog(context);
        else
          RankDialog().showRankDialog(context, rank + 1);
      }
    } catch (exception) {}
  }

  Future<Map<String, int>> getUsersPoints() async {
    CommonResponse result = await _cloudFiretoreRepository.getUsers();
    List<DocumentSnapshot> documents = result.data;
    Map<String, int> points = Map();

    documents.forEach((document) {
      var user = User.fromJson(document.data);
      points[user.uid] = user.points;
    });
    return points;
  }

  updatePointsInResults(Map<dynamic, dynamic> map) {
//    resultModel.getMap();
//    resultModel.ranks = map;
    _cloudFiretoreRepository.updateResults(
        resultModel.id, resultModel.getMap());
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

  get onDidReceiveLocalNotification => null;

  get onSelectNotification => null;

  @override
  void dispose() {}
}
