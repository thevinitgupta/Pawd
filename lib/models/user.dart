
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawd/models/task.dart';

class UserModel{
  String? uid;
  final String? emailId;
  String? password;
  String? displayName;
  List<TaskModel> tasks = [];

  UserModel({
    this.uid,
    this.emailId,
    this.password,
    this.displayName,
  });
  get email => emailId;
  get username => displayName;
}

