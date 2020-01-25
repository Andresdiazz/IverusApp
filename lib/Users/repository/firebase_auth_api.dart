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

  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await FirebaseAuth.instance
            .signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));

        return authResult.user;
      } else {
        throw Exception('Missing Google Auth Token');
      }
    } else {
      throw Exception('Google sign in aborted');
    }
  }

  //Firebase api google
  Future<FirebaseUser> signIn() async {
//    googleSignIn.signIn();
    try {
      googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      if (account != null) {
        return account.authentication.then((auth) async {
          AuthResult user = (await _auth.signInWithCredential(
              GoogleAuthProvider.getCredential(
                  idToken: auth.idToken, accessToken: auth.accessToken)));
          return user.user;
        }).then((error) {
          return null;
        });
      } else {
        return null;
      }
    });

    googleSignIn.signInSilently();

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
