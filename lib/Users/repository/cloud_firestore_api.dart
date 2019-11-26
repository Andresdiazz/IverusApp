import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Comments/model/comments.dart';
import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/model/result_model.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide.dart';
import 'package:cocreacion/Users/bloc/home_bloc.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import '../../CommonResponse.dart';
import '../../SharedPref.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String RESULT_DATES = "result_dates";
  final String TRIVIA = "trivia";
  final String LIVE = "live";
  final String IDEAS = "ideas";
  final String COMMENTS = "comments";
  final String VIDEOS = "videos";
  final String BELLEZA = "belleza";
  final String CPERSONAL = "cpersonal";
  final String IVERUS = "iverus";
  final String MODA = "moda";

  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<DocumentSnapshot> profileStream;
  StreamSubscription<QuerySnapshot> leaderboardStream;

  Future<void> updateUserData(User user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return await ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myIdeas': user.myIdeas,
      'myFavoriteIdeas': user.myFavoriteIdeas,
      'lastSignIn': DateTime.now(),
      'points': user.points == null ? 0 : user.points,
      'desc': user.desc,
      'phone': user.phone
    }, merge: true);
  }

  Future<void> updateIdeas(Ideas ideas) async {
    CollectionReference refIdeas = _db.collection(IDEAS);

    _auth.currentUser().then((FirebaseUser user) {
      refIdeas.add({
        'title': ideas.title,
        'likes': ideas.likes,
        'userOwner': _db.document("${USERS}/${user.uid}") //reference,
      }).then((DocumentReference dr) {
        dr.get().then((DocumentSnapshot snapshot) {
          //ID Place REFERENCE ARRAY
          DocumentReference refUsers = _db.collection(USERS).document(user.uid);
          refUsers.updateData({
            'myIdeas': FieldValue.arrayUnion(
                [_db.document("${IDEAS}/${snapshot.documentID}")])
          });
        });
      });
    });
  }

  Future<void> updateComments(Comments comments) async {
    //DocumentReference docRef = _db.collection(IDEAS).document(ideas.id);

    CollectionReference refComments =
        _db.collection(IDEAS).document().collection(COMMENTS);

    _auth.currentUser().then((FirebaseUser user) {
      refComments.add({
        'title': comments.title,
        'likes': comments.likes,
        'userOwner': _db.document("${USERS}/${user.uid}")
      }).then((DocumentReference dr) {
        dr.get().then((DocumentSnapshot snapshot) {
          //ID Place REFERENCE ARRAY
          DocumentReference refUsers = _db.collection(USERS).document(user.uid);
          refUsers.updateData({
            'myIdeas': FieldValue.arrayUnion(
                [_db.document("${IDEAS}/${snapshot.documentID}")])
          });
        });
      });
    });
  }

  List<Slide> buildIdeas(List<DocumentSnapshot> slideListSnapshot, User user) {
    List<Slide> ideasUser = List<Slide>();

    slideListSnapshot.forEach((i) {
      ideasUser.add(Slide(
          Ideas(
            title: i.data['title'],
            likes: i.data['likes'],
          ),
          User(
              uid: i.data['uid'],
              name: i.data['name'],
              photoURL: i.data['photo'],
              email: i.data['email']), onPressedFabIcon: () {
        likeIdea(i.documentID);
      }));
    });

    return ideasUser;
  }

  Future likeIdea(String idIdea) async {
    await _db
        .collection(IDEAS)
        .document(idIdea)
        .get()
        .then((DocumentSnapshot ds) {
      int likes = ds.data["likes"];

      _db.collection(IDEAS).document(idIdea).updateData({'likes': likes + 1});
    });
  }

  Future<CommonResponse> getProfile(String uid) async {
    return _db.collection(USERS).document(uid).get().then((onValue) {
      return CommonResponse(CommonResponse.successCode, onValue.data);
    }).catchError((error) {
      throw error;
    });
  }

  cancelOwnProfileStrem() {
    if (profileStream != null) {
      profileStream.cancel();
    }
  }

  Future<CommonResponse> getProfileStream(String uid) async {
    return _db.collection(USERS).document(uid).get().then((onValue) {
      return CommonResponse(CommonResponse.successCode, onValue.data);
    }).catchError((error) {
      throw error;
    });
  }

  ownProfileStream(HomeBloc homeBloc, String uid) {
    if (profileStream != null) {
      profileStream.cancel();
    }

    profileStream = Firestore.instance
        .collection(USERS)
        .document(uid)
        .snapshots()
        .listen((snapshot) {
      homeBloc.userController.sink.add(User.fromJson(snapshot.data));
      SharedPref()
          .save(SharedPref.user, homeBloc.userController.value.toString());
    });
  }

  getLeaderBoard(HomeBloc homeBloc) async {
    if (leaderboardStream != null) {
      leaderboardStream.cancel();
    }

    leaderboardStream = Firestore.instance
        .collection(USERS)
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        print(change.document.data.toString());

        switch (change.type) {
          case DocumentChangeType.added:
            homeBloc.handleData(User.fromJson(change.document.data), false);
            break;

          case DocumentChangeType.modified:
            homeBloc.handleData(User.fromJson(change.document.data), false);
            break;

          case DocumentChangeType.removed:
            homeBloc.handleData(User.fromJson(change.document.data), true);
            break;
        }
      });
    });

//    return _db.collection(USERS).getDocuments().then((onValue) {
//      List<User> data = List();
//      onValue.documents.forEach((document) {
//        var user = User.fromJson(document.data);
//        data.add(user);
//      });
//
//      return CommonResponse(CommonResponse.successCode, data);
//    }).catchError((error) {
//      throw error;
//    });
  }

  Future<int> getVideosCount() async {
    int size = 0;
    return _db.collection(IVERUS).getDocuments().then((snap) {
      size = size + snap.documents.length;

      return _db.collection(BELLEZA).getDocuments().then((snap) {
        size = size + snap.documents.length;

        return _db.collection(CPERSONAL).getDocuments().then((snap) {
          size = size + snap.documents.length;

          return _db.collection(MODA).getDocuments().then((snap) {
            size = size + snap.documents.length;
            return size;
          });
        });
      });
    });
  }

  Future<CommonResponse> updateImage(uid, filePath, ext) async {
    final String fileName = uid;

    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child(USERS).child(fileName);

    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
      StorageMetadata(contentType: 'image' + '/' + ext),
    );

    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);

    return downloadUrl.ref.getDownloadURL().then((url) {
      return CommonResponse(CommonResponse.successCode, url);
    }).catchError((error) {
      return CommonResponse(CommonResponse.errorCode, error.message);
    });
  }

  Future<CommonResponse> checkIfUserExists(String id) async {
    DocumentReference ref = _db.collection(USERS).document(id);

    return ref.get().then((res) {
      return CommonResponse(CommonResponse.successCode, res);
    }).catchError((error) {
      return CommonResponse(CommonResponse.errorCode, error);
    });
  }

  Future<CommonResponse> getCategoryData(String catName) {
    return _db.collection(catName).getDocuments().then((res) {
      return CommonResponse(CommonResponse.successCode, res.documents);
    });
  }

//  Likes api
  Future<CommonResponse> updateLikes(String uid, String videoId, String table,
      Map<dynamic, dynamic> likes) async {
//    get likes first
    return getProfile(uid).then((res) {
      Map<dynamic, dynamic> noLikes;
      var user = User.fromJson(res.data);
      noLikes = user.likes != null ? user.likes : Map();

//      if likes alre already there, just update else create an entry and update videos and user table
      noLikes[table + "_" + videoId] = likes[uid];

      user.likes = noLikes;
      return updateUser(user, videoId, table, likes);
    });
  }

//  to update likes
  Future<CommonResponse> updateUser(
      User user, String videoId, String table, Map<dynamic, dynamic> likes) {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData(user.getMap()).then((res) {
      return updateLikesTable(videoId, table, likes, user.uid);
    });
  }

  Future<CommonResponse> updateLikesTable(
      String videoId, String table, Map<dynamic, dynamic> likes, String uid) {
    DocumentReference ref = _db.collection(table).document(videoId);
    return ref.get().then((res) {
      Map<dynamic, dynamic> noLikes;

      noLikes = res.data['likes'] != null ? res.data['likes'] : Map();
      noLikes[uid] = likes[uid];

      return ref.setData({'likes': noLikes}, merge: true).then((res) {
        return CommonResponse(CommonResponse.successCode, "Success");
      }).catchError((error) {
        return CommonResponse(CommonResponse.errorCode, error);
      });
    });
  }

// share api's
  Future<CommonResponse> updateShare(
      String uid, String videoId, String table) async {
//    get likes first
    return getProfile(uid).then((res) {
      List<String> shares;
      var user = User.fromJson(res.data);
      shares = user.shares != null ? List<String>.from(user.shares) : List();

      shares.add(table + "_" + videoId);
      int points = user.points != null ? user.points : 0;
      points = points + 10;
      user.points = points;
      user.shares = shares;
      return updateUserShare(user, videoId, table);
    });
  }

//  to update likes
  Future<CommonResponse> updateUserShare(
      User user, String videoId, String table) {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData(user.getMap()).then((res) {
      return updateSharesTable(user.uid, videoId, table);
    });
  }

  Future<CommonResponse> updateSharesTable(
      String uid, String videoId, String table) {
    DocumentReference ref = _db.collection(table).document(videoId);
    return ref.get().then((res) {
      List<String> shares;
      shares = res.data['shares'] != null
          ? List<String>.from(res.data['shares'])
          : List();

      shares.add(uid);

      return ref.setData({'shares': shares}, merge: true).then((res) {
        return CommonResponse(CommonResponse.successCode, "Success");
      }).catchError((error) {
        return CommonResponse(CommonResponse.errorCode, error);
      });
    });
  }

  updatePointsOnVideoWatch(String uid, String table) async {
    return getProfile(uid).then((res) {
      var user = User.fromJson(res.data);
      int points = user.points != null ? user.points : 0;
      points = points + 20;
      user.points = points;
      DocumentReference ref = _db.collection(USERS).document(user.uid);
      return ref.setData(user.getMap()).then((res) {});
    });
  }

  Future<CommonResponse> getTutorial() {
    return _db
        .collection(LIVE)
        .document('0SpRp4sseF0DSvc19g5V')
        .get()
        .then((onValue) {
      return CommonResponse(CommonResponse.successCode, onValue.data);
    }).catchError((error) {
      throw error;
    });
  }

  Future<CommonResponse> getRank(String id) async {
    return _db.collection(RESULT_DATES).document(id).get().then((res) {
      return CommonResponse(CommonResponse.successCode, res.data);
    }).catchError((error) {
      return CommonResponse(CommonResponse.errorCode, error.toString());
    });
  }

  Future<CommonResponse> getResultTime() async {
    try {
      var snapshot = await _db.collection(RESULT_DATES).getDocuments();
      List<ResultModel> results = List();
      snapshot.documents.forEach((document) {
        results.add(ResultModel.fromJson(document.data));
      });
      DateFormat _df = DateFormat('yyyy-MM-dd HH:mm:ss');

      results.sort((a, b) {
        return _df.parse(a.time).compareTo(_df.parse(b.time));
      });

      ResultModel result;
      for (var i = 0; i < results.length; i++) {
        if (!_df.parse(results[i].time).isBefore(DateTime.now())) {
          result = results[i];
          break;
        }
      }

      return CommonResponse(CommonResponse.successCode, result.getMap());
    } catch (exception) {
      return CommonResponse(CommonResponse.successCode, exception.toString());
    }
  }

  Future<CommonResponse> getUsers() async {
    try {
      QuerySnapshot snapshot = await _db.collection(USERS).getDocuments();
      return CommonResponse(CommonResponse.successCode, snapshot.documents);
    } catch (exception) {
      return CommonResponse(CommonResponse.errorCode, exception.toString());
    }
  }

  updateResults(String id, map) {
    _db
        .collection(RESULT_DATES)
        .document(id)
        .updateData(map)
        .catchError((error) {
      print(error.toString());
    });
  }

  Future<CommonResponse> getTriviaPoints(String id) {
    return _db.collection(TRIVIA).document(id).get().then((snapshot) {
      var data = Map<String, dynamic>();
      data['puntos'] = 0;

      return snapshot.data == null
          ? CommonResponse(CommonResponse.successCode, data)
          : CommonResponse(CommonResponse.successCode, snapshot.data);
      ;
    }).catchError((error) {
      print(error.toString());
      return CommonResponse(CommonResponse.errorCode, error);
    });
  }

  updateTriviaPoints(String uid, int points) {
    getTriviaPoints(uid).then((res) {
      print(res.toString());
      var data = res.data as Map<String, dynamic>;
      if (data['puntos'] != null) {
        points += data['puntos'];
      }

      Map<String, dynamic> pointsMap = Map();
      pointsMap['puntos'] = points;

      _db.collection(TRIVIA).document(uid).setData(pointsMap);
      _db.collection(USERS).document(uid).updateData(pointsMap);
    });
  }
}
