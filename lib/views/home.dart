import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pawd/views/index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    Index(),
    Text("Calendar"),
    Text("Focus"),
    Text("Profile"),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Index();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    EvaIcons.menu2,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  Text(
                    "Index",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTL_JlCFnIGX5omgjEjgV9F3sBRq14eTERK9w&usqp=CAU"),
                  )
                ],
              ),
            ),
            PageStorage(bucket: bucket, child: currentScreen)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          EvaIcons.plus
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF121212),
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = screens[0];
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            currentTab==0 ? EvaIcons.home : EvaIcons.homeOutline,
                          size: 40.0,
                            color: Colors.white60,
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = screens[1];
                        currentTab = 1;
                      });
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          currentTab==1 ? EvaIcons.calendar : EvaIcons.calendarOutline,
                          size: 40.0,
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
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = screens[2];
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          currentTab==2 ? EvaIcons.clock : EvaIcons.clockOutline,
                          size: 40.0,
                          color: Colors.white60,
                          )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = screens[3];
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          currentTab==3 ? EvaIcons.person : EvaIcons.personOutline,
                          size: 40.0,
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
      )
    );
  }
}
