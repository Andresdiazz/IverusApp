import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocreacion/Comments/model/comments.dart';
import 'package:cocreacion/Ideas/model/ideas.dart';
import 'package:cocreacion/Ideas/ui/widgets/slide.dart';
import 'package:cocreacion/Users/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String IDEAS = "ideas";
  final String COMMENTS = "comments";

  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(User user) async{
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return await ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myIdeas': user.myIdeas,
      'myFavoriteIdeas': user.myFavoriteIdeas,
      'lastSignIn': DateTime.now()

    }, merge: true);
    
  }

  Future<void> updateIdeas(Ideas ideas) async{
    
    CollectionReference refIdeas = _db.collection(IDEAS);

    _auth.currentUser().then((FirebaseUser user){
      refIdeas.add({
        'title': ideas.title,
        'likes': ideas.likes,
        'userOwner': _db.document("${USERS}/${user.uid}")//reference,
      }).then((DocumentReference dr){
        dr.get().then((DocumentSnapshot snapshot){
          //ID Place REFERENCE ARRAY
          DocumentReference refUsers = _db.collection(USERS).document(user.uid);
          refUsers.updateData({
            'myIdeas': FieldValue.arrayUnion([
            _db.document("${IDEAS}/${snapshot.documentID}")
            ])
          });
        });
      });

    });
    
  }

  Future<void> updateComments(Comments comments) async{



    //DocumentReference docRef = _db.collection(IDEAS).document(ideas.id);

    CollectionReference refComments = _db.collection(IDEAS).document().collection(COMMENTS);

    _auth.currentUser().then((FirebaseUser user){
      refComments.add({
        'title': comments.title,
        'likes': comments.likes,
        'userOwner': _db.document("${USERS}/${user.uid}")
      }).then((DocumentReference dr){
        dr.get().then((DocumentSnapshot snapshot){
          //ID Place REFERENCE ARRAY
          DocumentReference refUsers = _db.collection(USERS).document(user.uid);
          refUsers.updateData({
            'myIdeas': FieldValue.arrayUnion([
              _db.document("${IDEAS}/${snapshot.documentID}")
            ])
          });


        });
      });
    });

  }

  List<Slide> buildIdeas(List<DocumentSnapshot> slideListSnapshot, User user){

    List<Slide> ideasUser = List<Slide>();

    slideListSnapshot.forEach((i){

      ideasUser.add(Slide(

          Ideas(
            title: i.data['title'],
            likes: i.data['likes'],
          ),
          User(
              uid: i.data['uid'],
              name: i.data['name'],
              photoURL: i.data['photo'],
              email: i.data['email']
          ),
          onPressedFabIcon: () {
            likeIdea(i.documentID);
          }
      )
      );

    }
    );

        return ideasUser;

  }



  Future likeIdea(String idIdea) async{
    await _db.collection(IDEAS).document(idIdea).get()
        .then((DocumentSnapshot ds){
          int likes = ds.data["likes"];

          _db.collection(IDEAS).document(idIdea)
              .updateData({
            'likes': likes+1
          });

    });
  }




}
