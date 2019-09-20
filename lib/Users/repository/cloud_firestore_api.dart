import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Comments/model/comments.dart';
import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../CommonResponse.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String IDEAS = "ideas";
  final String COMMENTS = "comments";
  final String VIDEOS = "videos";

  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      'points': user.points,
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

  Future<CommonResponse> getLeaderBoard() async {
    return _db
        .collection(USERS)
        .orderBy("points", descending: true)
        .limit(10)
        .getDocuments()
        .then((onValue) {
      List<User> data = List();
      onValue.documents.forEach((document) {
        var user = User.fromJson(document.data);
        data.add(user);
      });

      return CommonResponse(CommonResponse.successCode, data);
    }).catchError((error) {
      throw error;
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
      return CommonResponse(CommonResponse.successCode, res.exists);
    }).catchError((error) {
      return CommonResponse(CommonResponse.errorCode, error);
    });
  }

  Future<CommonResponse> updateLikes(
      String uid, String videoId, String table, bool isLike) async {
//    get likes first
    return getProfile(uid).then((res) {
      var user = User.fromJson(res.data);
      if (user.likes != null) user.likes = List();
      if (isLike)
        user.likes.add(table + "_" + videoId);
      else
        user.likes.remove(table + "_" + videoId);
      return updateUser(user, videoId, table, isLike);
    });
  }

//  to update likes
  Future<CommonResponse> updateUser(
      User user, String videoId, String table, bool isLike) {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData(user.getMap()).then((res) {
      return updateLikesTable(user.uid, videoId, table, isLike);
    });
  }

  Future<CommonResponse> updateLikesTable(
      String uid, String videoId, String table, bool isLike) {
    DocumentReference ref = _db.collection(table).document(videoId);
    return ref.get().then((res) {
      List<String> likes;
      likes = res.data['likes'] != null ? res.data['likes'] : List();

      if (isLike)
        likes.add(uid);
      else
        likes.remove(uid);

      return ref.setData({'likes': likes}, merge: true).then((res) {
        return CommonResponse(CommonResponse.successCode, "Success");
      }).catchError((error) {
        return CommonResponse(CommonResponse.errorCode, error);
      });
    });
  }

  Future<CommonResponse> getCategoryData(String catName) {
    return _db.collection(catName).getDocuments().then((res) {
      return CommonResponse(CommonResponse.successCode, res.documents);
    });
  }
}
