import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseAuthService();

  // Sign up with email and password
  Stream<UserModel> retrieveCurrentUser() {
    return auth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(uid: user.uid, emailId: user.email, displayName: user.displayName);
      } else {
        return  UserModel(uid: "uid");
      }
    });
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  // Log in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {

      final app=  await auth.app;
      final user = await auth.currentUser;
      await auth.signOut();

      final UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  // Log out
  Future<void> signOut() async {
    await auth.signOut();
  }
}
