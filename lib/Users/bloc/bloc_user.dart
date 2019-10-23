import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Comments/model/comments.dart';
import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/ui/screens/user_ideas.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide.dart';

import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:cocreacion/Users/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_api.dart';

import '../../CommonResponse.dart';
import '../../SharedPref.dart';
import 'home_bloc.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  UserBloc() {
    scheduleNotification();
  }

  //Flujo de datos - Streams

  //Stream - Firebase

  //StreamController
  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;

  Stream<FirebaseUser> get authStatus => streamFirebase;

  get onDidReceiveLocalNotification => null;

  get onSelectNotification => null;

  //Casos uso
  //1. SignIn a la aplicacion Google
  Future<FirebaseUser> signIn() {
    return _auth_repository.signInFirebase();
  }

  //2. SignIn with Facebook

  //3. SignIn with Phone

  //3. Registra usuario en base de datos
  final _cloudFiretoreRepository = CloudFirestoreRepository();

  void updateUserData(User user) {
    _cloudFiretoreRepository.checkIfUserExists(user.uid).then((res) {
      var result = res.data as DocumentSnapshot;
      if (!result.exists) {
        _cloudFiretoreRepository.updateUserDataFiretore(user).then((data) {});
      }
    }).catchError((error) {});
  }

  Future<void> updateIdeas(Ideas ideas) =>
      _cloudFiretoreRepository.updateIdeas(ideas);

  Future<void> updateComments(Comments comments) =>
      _cloudFiretoreRepository.updateComments(comments);

  Stream<QuerySnapshot> ideasListStream =
      Firestore.instance.collection(CloudFirestoreAPI().IDEAS).snapshots();

  Stream<QuerySnapshot> get ideasStream => ideasListStream;

  Stream<QuerySnapshot> userListStream =
      Firestore.instance.collection(CloudFirestoreAPI().USERS).snapshots();

  Stream<QuerySnapshot> get userStream => userListStream;

  //StreamZip<QuerySnapshot> bothStreams = StreamZip([ideasListStream, userListStream]);

  List<Slide> buildIdeas(List<DocumentSnapshot> slideListSnapshot, User user) =>
      _cloudFiretoreRepository.buildIdeas(slideListSnapshot, user);

  signOut() {
    SharedPref().clear();
    _auth_repository.signOut();
  }

  Future<DocumentSnapshot> checkIfAlreadyExists(String uid) {
    return _cloudFiretoreRepository.checkIfUserExists(uid).then((res) {
      return res.data as DocumentSnapshot;
    });
  }

  @override
  void dispose() {}

  scheduleNotification() async {
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
        new DateTime.now().add(new Duration(days: 1));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      '123',
      '1',
      'scheduled notification',
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.cancel(0);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Long time no see',
        'Come back to the app and win gifts',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}
