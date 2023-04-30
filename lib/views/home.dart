import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawd/views/index.dart';
import 'package:pawd/res/colors.dart';
import 'package:pawd/res/sizes.dart';
import 'package:pawd/res/strings.dart';
import 'package:pawd/views/on_boarding.dart';
import 'package:pawd/widgets/Chart.dart';
import 'package:pawd/widgets/Menu.dart';
import 'package:pawd/widgets/NavButton.dart';

import '../blocs/auth_bloc.dart';
import '../blocs/data_bloc.dart';
import '../utils/data_repository.dart';
import '../widgets/Loader.dart';
import '../widgets/TaskPlaceholder.dart';
import 'package:pawd/views/Focus.dart' as Focus;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    const IndexPage(),
    const Chart(),
    //Focus is also present in material package
    const Focus.Focus(),
    const TaskPlaceholder(),
  ];



  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const IndexPage();

  @override
  Widget build(BuildContext context) {
    final DataBloc dataBloc = context.read<DataBloc>();
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
  listener: (context, state) {
    if(state is AuthenticationLoading){
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Loader(message : "Logging out");
        },
      );
    }
    if(state is UnAuthenticated){
      Navigator.pop(context);
    }
  },
  builder: (context, state) {
    if(state is UnAuthenticated){
      Navigator.popUntil(context, (route) => true);
      return OnboardingScreen();
    }
    return Scaffold(
        drawer: NavBar(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: p_5, horizontal: p_20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavButton(),
                    Text(
                      homeHeadings[currentTab],
                      style:
                          TextStyle(fontSize: text_lg, color: Colors.white),
                    ),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColorLight,
                      backgroundImage: const NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTL_JlCFnIGX5omgjEjgV9F3sBRq14eTERK9w&usqp=CAU"),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: PageStorage(bucket: bucket, child: currentScreen)
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TextEditingController title = TextEditingController();
            TextEditingController description = TextEditingController();
            showModalBottomSheet(
              backgroundColor: navColor,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Title cannot be empty";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: title,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white38, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2)),
                            labelText: "Title",
                            labelStyle: const TextStyle(
                                color: Colors.white38, fontSize: text_md),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Title cannot be empty";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: description,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white38, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2)),
                            labelText: "description",
                            labelStyle: const TextStyle(
                                color: Colors.white38, fontSize: text_md),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Handle send button click
                            dataBloc.add(AddTask(
                                email: dataBloc.userData?["email"],
                                task: {
                                  "title": title.text,
                                  "description": description.text
                                }));
                          },
                          child: Icon(EvaIcons.paperPlaneOutline),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: const Icon(EvaIcons.plus),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: navColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: p_10,
          child: Container(
            height: p_70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: p_40,
                      onPressed: () {
                        setState(() {
                          currentScreen = screens[0];
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentTab == 0
                                ? EvaIcons.home
                                : EvaIcons.homeOutline,
                            size: p_40,
                            color: Colors.white60,
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: p_40,
                      onPressed: () {
                        setState(() {
                          currentScreen = screens[1];
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentTab == 1
                                ? EvaIcons.calendar
                                : EvaIcons.calendarOutline,
                            size: p_40,
                            color: Colors.white60,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MaterialButton(
                      minWidth: p_40,
                      onPressed: () {
                        setState(() {
                          currentScreen = screens[2];
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentTab == 2
                                ? EvaIcons.clock
                                : EvaIcons.clockOutline,
                            size: p_40,
                            color: Colors.white60,
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: p_40,
                      onPressed: () {
                        setState(() {
                          currentScreen = screens[3];
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentTab == 3
                                ? EvaIcons.person
                                : EvaIcons.personOutline,
                            size: p_40,
                            color: Colors.white60,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  },
);
  }
}
