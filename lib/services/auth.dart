import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create a user object based on FirebaseUser
  Users _userFromFirebaseUser(dynamic user) {
    return user = Users(uid: user.user.uid);
  }

  // sign in anonmous
  Future signInAnon() async {
    try {
      UserCredential user = await _auth.signInAnonymously();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // sign in with email & password

  // register with email & password

  //sign out
}
