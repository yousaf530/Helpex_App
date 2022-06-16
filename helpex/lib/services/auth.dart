import 'package:firebase_auth/firebase_auth.dart';
//import 'package:helpex_app/models/google_user.dart';
import 'package:helpex_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj
  MyUser? _userFromFirebaseUser(User? user) {
    return MyUser(uid: user?.uid);
  }

  //auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //create googleUser Object
  // GoogleUser? _userFromGoogleUser(User? user) {
  //   return GoogleUser(uid: uid);
  // }

  // Stream<GoogleUser?> get gUser {
  //   return _auth.authStateChanges().map(_userFromGoogleUser);
  // }

  //sign in with email pass
  Future signInWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reg with email pass
  Future registerWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
