import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nanoid/nanoid.dart';

class DatabaseRepository{
  final FirebaseFirestore _userDb;
  DatabaseRepository({db}) : _userDb = db?? FirebaseFirestore.instance;

  FutureOr<void> createDoc(User user)async{
    return await _userDb.collection("Users").doc(user.email).set({
      "email" : user.email,
      "photoUrl" : user.photoURL,
      "displayName" : user.displayName ?? user.email?.substring(0,user.email?.lastIndexOf('@')),
      "tasks" : {}
    });
  }

  FutureOr<DocumentSnapshot<Map<String, dynamic>>> getUser(String email) async{
    return await _userDb.collection("Users").doc(email).get();
  }

  FutureOr<void> addTask(String email, Map<String, String> task) async{
    final taskId = nanoid(10);
    return await _userDb.collection("Users").doc(email).update({
        'tasks.$taskId' : task
    });
  }

  FutureOr<void> updateTask(String email, String taskId, Map<String, String> task) async{
    return await _userDb.collection("Users").doc(email).update({
        'tasks.$taskId' : task
    });
  }

  FutureOr<void> deleteTask(String email, String taskId) async{
    return await _userDb.collection("Users").doc(email).update({
      'tasks.$taskId' : FieldValue.delete()
    });
  }

  FutureOr<void> deleteAllTasks(String email) async{
    return await _userDb.collection("Users").doc(email).update({
      'tasks' : {}
    });
  }

  FutureOr<void> updateUserDetails(String email, String field, String value) async{
    return await _userDb.collection("Users").doc(email).update({
      field : value
    });
  }
}