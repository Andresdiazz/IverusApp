import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  //Firebase api google
  Future<FirebaseUser> signIn() async {
    return googleSignIn.signIn().then((googleSignInAccount) {
      googleSignInAccount.authentication.then((value) async {
        AuthResult user = (await _auth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: value.idToken,
                accessToken: value.accessToken))) as AuthResult;
        return user.user;
      }).catchError((error) {
        print(error);
      });
    }).catchError((e) {
      print(e);
    });
//    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

//    AuthResult user = (await _auth.signInWithCredential(
//        GoogleAuthProvider.getCredential(
//            idToken: gSA.idToken, accessToken: gSA.accessToken))) as AuthResult;
//    return user.user;
  }

//Firebase api Phone

  signOut() async {
    var facebooklogin = new FacebookLogin();

    await _auth.signOut().then((onValue) => print("Sesion cerrada"));
    googleSignIn.signOut();
    facebooklogin.logOut();
    print("Sesiones cerradas");
  }
}
