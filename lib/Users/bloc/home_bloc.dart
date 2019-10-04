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
  final _leaderBoardController = BehaviorSubject<List<User>>();
  final _videosCountController = BehaviorSubject<int>();

  Observable<User> get user => userController.stream;

  List<User> allUsers = List();

  Observable<List<User>> get leaderBoard => _leaderBoardController.stream;

  Observable<int> get videosCount => _videosCountController.stream;

  HomeBloc() {
    FirebaseAuth.instance.currentUser().then((user) {
      _cloudFirestoreRepository.ownProfileStream(this, user.uid);

      _cloudFirestoreRepository.getLeaderBoard().then((res) {
        List<User> data = List();
        allUsers.addAll(res.data);

        List<User> temp = allUsers.getRange(0, 5).toList();

//        User tempUser = temp.firstWhere((i) => i.uid == user.uid);
        if (temp.where((i) => i.uid == user.uid).length == 0) {
          int rank = allUsers.indexWhere((i) => i.uid == user.uid) + 1;
          allUsers[rank - 1].rank = rank;
          temp.add(allUsers[rank - 1]);
        }

        temp[0].gift = '2K';
        temp[1].gift = '1K';
        temp[2].gift = '500K';

        _leaderBoardController.sink.add(temp);
      }).then((exc) {
        print(exc.toString());
      });
    });

    _cloudFirestoreRepository.getVideosCount().then((onValue) {
      _videosCountController.sink.add(onValue);
    });
  }

  @override
  void dispose() {
    userController.close();
    _leaderBoardController.close();
    _videosCountController.close();
  }
}
