
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pawd/models/task.dart';

class UserModel{
  String? uid;
  String? emailId;
  String? displayName;
  String? photoURL;
  List<TaskModel> tasks = [];
  UserModel.fromUser(User user){
    this.emailId = user.email;
    this.displayName = user.displayName ?? this.emailId?.substring(0,this.emailId?.lastIndexOf('@'));
    this.photoURL = user.photoURL;
    this.tasks = [];
  }
  UserModel.fromJson(Map<String,dynamic> userMap){
    this.emailId = userMap["email"];
    this.displayName = userMap["displayName"] ?? this.emailId?.substring(0,this.emailId?.lastIndexOf('@'));
    this.photoURL = userMap["photoURL"];
    this.tasks = userMap["tasks"] ?? [];
  }
  get email => emailId;
  get username => displayName;
  toJson(){
    return {
      "email" : this.emailId,
      "displayName" : this.displayName ?? this.emailId?.substring(0,this.emailId?.lastIndexOf('@')),
      "photoURL" : this.photoURL,
      "tasks" : this.jsonTasks()
    };
  }

  jsonTasks(){
    List<dynamic> currentTasks = [];
    this.tasks.forEach((element) {
      currentTasks.add(
        element.toJson()
      );
    });
    return currentTasks;
  }

}

