import 'dart:convert';

import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../SharedPref.dart';

class HomeBloc extends Bloc {
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  final userController = BehaviorSubject<User>();
  final leaderBoardController = BehaviorSubject<List<User>>();
  final _videosCountController = BehaviorSubject<int>();
  String ownId;

  Observable<User> get user => userController.stream;

  List<User> allUsers = List();

  Observable<List<User>> get leaderBoard => leaderBoardController.stream;

  Observable<int> get videosCount => _videosCountController.stream;

  HomeBloc() {
    FirebaseAuth.instance.currentUser().then((user) {
      ownId = user.uid;
      _cloudFirestoreRepository.ownProfileStream(this, user.uid);
      _cloudFirestoreRepository.getLeaderBoard(this);
    });

    _cloudFirestoreRepository.getVideosCount().then((onValue) {
      _videosCountController.sink.add(onValue);
    });
  }

  handleData(User user, bool delete) {
    int p = user.points == null ? 0 : user.points;

    user.points = p;

    List<User> users;
    users = leaderBoardController.value == null
        ? List()
        : leaderBoardController.value;

    users.forEach((user) {
      user.gift = "";
    });

    if (users.where((i) => i.uid == user.uid).length > 0) {
      users.remove(users.firstWhere((i) => i.uid == user.uid) != null);
    }
    users.add(user);

    users.sort((a, b) {
      return a.points.compareTo(b.points);
    });

    List<User> tempList = users.reversed.toList();

    if (tempList.length > 5) {
      List<User> temp = tempList.getRange(0, 5).toList();

//        User tempUser = temp.firstWhere((i) => i.uid == user.uid);
      if (temp.where((i) => i.uid == ownId).length == 0 &&
          tempList.where((i) => i.uid == ownId).length > 0) {
        int rank = tempList.indexWhere((i) => i.uid == ownId) + 1;
        tempList[rank - 1].rank = rank;
        temp.add(tempList[rank - 1]);
      }

      temp[0].gift = '2K';
      temp[1].gift = '1K';
      temp[2].gift = '500K';
      leaderBoardController.sink.add(temp);
    } else
      leaderBoardController.sink.add(tempList);
  }

  @override
  void dispose() {
    userController.close();
    leaderBoardController.close();
    _videosCountController.close();
  }
}
