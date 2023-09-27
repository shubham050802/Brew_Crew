import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create a user object based on FirebaseUser
  Users? _userFromFirebaseUser(dynamic user) {
    return user != null ? Users(uid: user.toString()) : null;
  }

  Stream<Users?> get user1 {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anonmous
  Future signInAnon() async {
    try {
      UserCredential user = await _auth.signInAnonymously();
      return _userFromFirebaseUser(user.user?.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: user.user!.uid);
      return _userFromFirebaseUser(user.user?.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //create a new document for the user with the uid
      await DatabaseService(uid: user.user!.uid)
          .updateUserData('0', 'new Crew Member', 100);
      return _userFromFirebaseUser(user.user?.uid);
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
