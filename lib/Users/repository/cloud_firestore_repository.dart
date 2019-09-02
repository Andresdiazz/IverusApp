import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Comments/model/comments.dart';
import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/ui/screens/user_ideas.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_api.dart';


class CloudFirestoreRepository{

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFiretore(User user) => _cloudFirestoreAPI.updateUserData(user);
  Future<void> updateIdeas(Ideas ideas) => _cloudFirestoreAPI.updateIdeas(ideas);

  Future<void> updateComments(Comments comments) => _cloudFirestoreAPI.updateComments(comments);

  List<Slide> buildIdeas(List<DocumentSnapshot> slideListSnapshot, User user) => _cloudFirestoreAPI.buildIdeas(slideListSnapshot, user);

}