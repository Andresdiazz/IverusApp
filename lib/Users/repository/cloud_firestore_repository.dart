import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Comments/model/comments.dart';
import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/ui/screens/user_ideas.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide.dart';
import 'package:cocreacion/Users/bloc/home_bloc.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:cocreacion/Users/repository/cloud_firestore_api.dart';

import '../../CommonResponse.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  Future<void> updateUserDataFiretore(User user) =>
      _cloudFirestoreAPI.updateUserData(user);

  Future<void> updateIdeas(Ideas ideas) =>
      _cloudFirestoreAPI.updateIdeas(ideas);

  Future<void> updateComments(Comments comments) =>
      _cloudFirestoreAPI.updateComments(comments);

  List<Slide> buildIdeas(List<DocumentSnapshot> slideListSnapshot, User user) =>
      _cloudFirestoreAPI.buildIdeas(slideListSnapshot, user);

  Future<CommonResponse> getProfile(String uid) =>
      _cloudFirestoreAPI.getProfile(uid);

  Future<CommonResponse> ownProfileStream(HomeBloc homeBloc, String uid) =>
      _cloudFirestoreAPI.ownProfileStream(homeBloc, uid);

  cancelOwnProfileStrem() => _cloudFirestoreAPI.cancelOwnProfileStrem();

  getLeaderBoard(HomeBloc homeBlo) =>
      _cloudFirestoreAPI.getLeaderBoard(homeBlo);

  Future<CommonResponse> updateImage(String uid, String filePath, String ext) =>
      _cloudFirestoreAPI.updateImage(uid, filePath, ext);

  Future<CommonResponse> checkIfUserExists(String id) =>
      _cloudFirestoreAPI.checkIfUserExists(id);

  Future<CommonResponse> updateLikes(String uid, String videoId, String table,
          Map<dynamic, dynamic> likes) =>
      _cloudFirestoreAPI.updateLikes(uid, videoId, table, likes);

  Future<CommonResponse> updateShare(
          String uid, String videoId, String table) =>
      _cloudFirestoreAPI.updateShare(
        uid,
        videoId,
        table,
      );

  Future<CommonResponse> getCategoryData(String table) =>
      _cloudFirestoreAPI.getCategoryData(table);

  Future<int> getVideosCount() => _cloudFirestoreAPI.getVideosCount();

  updatePointsOnVideoWatch(String uid, String table, String videoId) =>
      _cloudFirestoreAPI.updatePointsOnVideoWatch(uid, table, videoId);

  Future<CommonResponse> getTutorial() => _cloudFirestoreAPI.getTutorial();

  Future<CommonResponse> getRank(String id) => _cloudFirestoreAPI.getRank(id);

  Future<CommonResponse> getResultTime() => _cloudFirestoreAPI.getResultTime();

  Future<CommonResponse> getUsers() => _cloudFirestoreAPI.getUsers();

  updateResults(String id, map) => _cloudFirestoreAPI.updateResults(id, map);

  Future<CommonResponse> getTriviaPoints(String id) =>
      _cloudFirestoreAPI.getTriviaPoints(id);

  updateTriviaPoints(String id, int points) =>
      _cloudFirestoreAPI.updateTriviaPoints(id, points);
}
