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
import 'package:pawd/widgets/TaskItem.dart';
import 'package:pawd/widgets/TaskPlaceholder.dart';

import '../blocs/auth_bloc.dart';
import '../utils/data_repository.dart';
import '../widgets/Loader.dart';

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
        if (state is DataLoading) {
          dataBloc.add(FetchData(email: user.email!));
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Loader(message : "Loading yours tasks");
            },
          );
        }
        if (state is DataUpdated) {
          Navigator.pop(context);
          dataBloc.add(FetchData(email: user.email!));
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Loader(message: 'Adding new task...');
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
          dataBloc.add(FetchData(email: user.email!));
        }
        if (state is DataLoaded) {
          Map<String, dynamic> taskMap = dataBloc.userData?["tasks"];
          List<dynamic> tasks = taskMap.entries.map((entry) => entry.value).toList();
          if (tasks.length != 0) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: p_10, horizontal: p_15),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  Padding(
                      padding: const EdgeInsets.symmetric(vertical: p_15, horizontal: 0),
                      child: TaskItem(task: tasks[index],),
                    );
                  }),
            );
          } else {
            return TaskPlaceholder();
          }
        }
        return TaskPlaceholder();
      },
    );
  }
}
