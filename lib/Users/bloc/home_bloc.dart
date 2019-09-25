import 'dart:convert';

import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../SharedPref.dart';

class HomeBloc extends Bloc {
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  final _userController = BehaviorSubject<User>();
  final _leaderBoardController = BehaviorSubject<List<User>>();
  final _videosCountController = BehaviorSubject<int>();

  Observable<User> get user => _userController.stream;

  Observable<List<User>> get leaderBoard => _leaderBoardController.stream;

  Observable<int> get videosCount => _videosCountController.stream;

  HomeBloc() {
    FirebaseAuth.instance.currentUser().then((user) {
      _cloudFirestoreRepository.getProfile(user.uid).then((res) {
        _userController.sink.add(User.fromJson(res.data));

        SharedPref().save(SharedPref.user, _userController.value.toString());
      }).then((exc) {
        print(exc);
      });

      _cloudFirestoreRepository.getLeaderBoard().then((res) {
        List<User> data = List();
        data.addAll(res.data);

        data[0].gift = '2K';
        data[1].gift = '1K';
        data[2].gift = '500K';

        _leaderBoardController.sink.add(res.data);
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
    _userController.close();
    _leaderBoardController.close();
    _videosCountController.close();
  }
}
