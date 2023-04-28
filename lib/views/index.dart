import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawd/blocs/data_bloc.dart';
import 'package:pawd/res/colors.dart';
import 'package:pawd/res/strings.dart';
import 'package:pawd/res/sizes.dart';

import '../blocs/auth_bloc.dart';
import '../utils/data_repository.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {


  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthenticationBloc>();
    final dataBloc = BlocProvider.of<DataBloc>(context);
    final User user = authBloc.user!;
    return BlocConsumer<DataBloc, DataState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is DataLoading) {
          print("Loading called");
          dataBloc.add(FetchData(email: user.email!));
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.purple),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Loading your tasks...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        if (state is DataUpdated) {
          print("Update called");
          Navigator.pop(context);
          dataBloc.add(FetchData(email: user.email!));
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.purple),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Adding new task...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        if (state is DataLoaded) {
          Navigator.popUntil(context, ModalRoute.withName('/home'));
        }

        if (state is CloseNewTask) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is DataInitial) {
          print(user.email);
          dataBloc.add(FetchData(email: user.email!));
        }
        if (state is DataLoaded) {
          Map<String, dynamic> tasks = dataBloc.userData?["tasks"];
          List<dynamic> keys = tasks.entries.map((entry) => entry.value).toList();
          print(keys);
          if (tasks.length != 0) {
            print(tasks.runtimeType);
            return Container(
              padding: EdgeInsets.symmetric(vertical: p_10, horizontal: p_15),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  Padding(
                      padding: const EdgeInsets.symmetric(vertical: p_15, horizontal: 0),
                      child: ListTile(
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
                                      Text("${keys[index]["title"]}", style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: text_md
                                      ),),
                                      const SizedBox(height: p_30,),
                                      Text("${keys[index]["description"]}", style: const TextStyle(
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
                        contentPadding: EdgeInsets.symmetric(vertical: p_15, horizontal: p_10),
                        leading: Radio(
                          value: "completed",
                          fillColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColorLight),
                          onChanged: (String? value){},
                          groupValue: '',),
                        title: Text("${keys[index]["title"]}", style: TextStyle(
                          color: Colors.white,
                          fontSize: text_md
                        ),),
                        subtitle: Text("${keys[index]["description"].substring(min<num>(keys[index]["description"].length, 15))}...", style: TextStyle(
                          color: Colors.white54,
                          fontSize: text_sm
                        ),),
                        tileColor: tileColor,
                        textColor: Colors.white,
                      ),
                    );
                  }),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: 'hero-image',
                    child: SvgPicture.asset(
                      indexImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: p_20),
                  Text(
                    'What do you want to do today? ${dataBloc.userData?["displayName"]}',
                    style: TextStyle(fontSize: p_25, color: Colors.white70),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // RepositoryProvider.of<UserRepository>(context).signInWithCredentials(email.text, password.text),
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(AuthenticationSignedOut());
                      },
                      child: const Text('Signout',
                          style: TextStyle(
                            fontSize: text_md,
                            fontWeight: FontWeight.w300,
                          )),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, p_65),
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: p_20, vertical: p_14),
                      )),
                  const SizedBox(
                    height: p_10,
                  ),
                  const Text("Tap + to add your tasks",
                      style:
                          TextStyle(fontSize: text_sm, color: Colors.white54))
                ],
              ),
            );
          }
        }
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: 'hero-image',
                child: SvgPicture.asset(
                  indexImage,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: p_20),
              Text(
                'What do you want to do today? ${user?.email}',
                style: TextStyle(fontSize: p_25, color: Colors.white70),
              ),
              ElevatedButton(
                  onPressed: () {
                    // RepositoryProvider.of<UserRepository>(context).signInWithCredentials(email.text, password.text),
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationSignedOut());
                  },
                  child: const Text('Signout',
                      style: TextStyle(
                        fontSize: text_md,
                        fontWeight: FontWeight.w300,
                      )),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, p_65),
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: p_20, vertical: p_14),
                  )),
              const SizedBox(
                height: p_10,
              ),
              const Text("Tap + to add your tasks",
                  style: TextStyle(fontSize: text_sm, color: Colors.white54))
            ],
          ),
        );
      },
    );
  }
}

class TaskList extends StatelessWidget {
  final Map<String, dynamic> tasks;

  const TaskList({required this.tasks}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final item = tasks.entries.elementAt(index).value;
            return SizedBox(
              height: 20,
              child: Text(item.title),
            );
          }),
    );
  }
}
