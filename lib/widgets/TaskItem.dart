import 'dart:math';

import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../res/sizes.dart';

class TaskItem extends StatelessWidget {
  final Map<String, dynamic> task;
  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return Dialog(
            backgroundColor: tileColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${task["title"]}", style: const TextStyle(
                        color: Colors.white,
                        fontSize: text_md
                    ),),
                    const SizedBox(height: p_30,),
                    Text("${task["description"]}", style: const TextStyle(
                        color: Colors.white54,
                        fontSize: text_sm
                    ),),
                  ],
                ),
              ),
            ),
          );
        });
      },
      contentPadding: const EdgeInsets.symmetric(vertical: p_15, horizontal: p_10),
      leading: Radio(
        value: "completed",
        fillColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColorLight),
        onChanged: (String? value){},
        groupValue: '',),
      title: Text("${task["title"]}", style: const TextStyle(
          color: Colors.white,
          fontSize: text_md
      ),),
      subtitle: Text("${task["description"].substring(min<num>(task["description"].length, 15))}...", style: const TextStyle(
          color: Colors.white54,
          fontSize: text_sm
      ),),
      tileColor: tileColor,
      textColor: Colors.white,
    );
  }
}
