import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc {
  final _cloudFiretoreRepository = CloudFirestoreRepository();
  final _userController = BehaviorSubject<User>();

  HomeBloc() {
    FirebaseAuth.instance.currentUser().then((user) {
      _cloudFiretoreRepository.getProfile(user.uid).then((res){
        _userController.sink.add(User.fromJson(res.data));
      }).then((exc){
        print(exc);
      });
    });
  }

  Observable<User> get user =>
      _userController.stream;

  @override
  void dispose() {
    _userController.close();
  }
}
