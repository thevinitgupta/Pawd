import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';
import 'authentication.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  UserRepository({ firebaseAuth }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  Future<UserCredential> signInWithCredentials(String email, String password) async{
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  Future<UserCredential> signUp(String email, String password)async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async{
    return _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    bool signedIn = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        signedIn = false;
      } else {
        signedIn = true;
      }
    });
    return signedIn;
  }
  Future<User?> getUser()async{
    late User? firebaseUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      firebaseUser = user;
    });
    return firebaseUser;
  }
}

class AppException implements Exception {
  final String message;

  AppException(this.message);
}
