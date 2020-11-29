import 'package:Sikad/error_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class AppUser {
  const AppUser({@required this.uid});
  final String uid;
}

class FireBaseAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String _errormsg;
  UserCredential authResult;

  String errorMsg() {
    print(_errormsg);
    return getMessageFromErrorCode(_errormsg);
  }

  AppUser userFromFirebase(User user) {
    return user == null ? null : AppUser(uid: user.uid);
  }

  Stream<AppUser> get onAuthStateChanged {
    return auth.authStateChanges().map(userFromFirebase);
  }

  Future<AppUser> signInWithGoogle() async {
    final GoogleSignInAccount _googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleSignInAuthentication =
        await _googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: _googleSignInAuthentication.accessToken,
      idToken: _googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User user = auth.currentUser;

    return userFromFirebase(user);
  }

  Future<AppUser> signIn({String email, String password}) async {
    try {
      final _authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      authResult = _authResult;
      return userFromFirebase(_authResult.user);
    } on FirebaseAuthException catch (e) {
      _errormsg = e.code;
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> signUp({String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('function is called');
    } on FirebaseAuthException catch (e) {
      _errormsg = e.code;
      print(e.code);
    } catch (e) {
      _errormsg = e.code;
    }
  }

  Future<void> signOut() async {
    final _user = auth.currentUser;

    if (_user.providerData[0].providerId == 'gmail.com') {
      return await _googleSignIn.signOut();
    } else {
      return await auth.signOut();
    }
  }
}
