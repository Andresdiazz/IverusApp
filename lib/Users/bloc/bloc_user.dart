import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Comments/model/comments.dart';
import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/ui/screens/user_ideas.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide.dart';

import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:cocreacion/Users/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_api.dart';

class UserBloc implements Bloc {

  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams

  //Stream - Firebase

  //StreamController
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;


  //Casos uso
  //1. SignIn a la aplicacion Google
  Future<FirebaseUser> signIn() {
    return _auth_repository.signInFirebase();
  }

  //2. SignIn with Facebook


  //3. SignIn with Phone

  //3. Registra usuario en base de datos
  final _cloudFiretoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFiretoreRepository.updateUserDataFiretore(user);

  Future<void> updateIdeas(Ideas ideas) => _cloudFiretoreRepository.updateIdeas(ideas);
  Future<void> updateComments(Comments comments) => _cloudFiretoreRepository.updateComments(comments);

  Stream<QuerySnapshot> ideasListStream = Firestore.instance.collection(CloudFirestoreAPI().IDEAS).snapshots();
  Stream<QuerySnapshot> get ideasStream => ideasListStream;

  Stream<QuerySnapshot> userListStream = Firestore.instance.collection(CloudFirestoreAPI().USERS).snapshots();
  Stream<QuerySnapshot> get userStream => userListStream;






  //StreamZip<QuerySnapshot> bothStreams = StreamZip([ideasListStream, userListStream]);


  List<Slide> buildIdeas(List<DocumentSnapshot> slideListSnapshot, User user) => _cloudFiretoreRepository.buildIdeas(slideListSnapshot, user);

  signOut(){
    _auth_repository.signOut();
  }




  @override
  void dispose() {
    // TODO: implement dispose
  }

}