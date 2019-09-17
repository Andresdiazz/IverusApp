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

  Future<CommonResponse> updateLikes(String uid, String videoId) async {
    return getProfile(uid).then((res) {
      var user = User.fromJson(res.data);
      if (user.likes != null) user.likes = List();
      user.likes.add(videoId);
      updateUser(user).then((res) {});
    });

    DocumentReference ref = _db.collection(USERS).document(uid);
  }

  Future<void> updateUser(User user) {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData(user.getMap());
  }
}
