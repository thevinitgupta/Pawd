import 'package:flutter/material.dart';
import 'package:pawd/res/colors.dart';
import 'package:pawd/widgets/NavItem.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<dynamic> items = [
    {"text":"App Settings", "color" : Colors.white},
    {"text":"Change name", "color" : Colors.white},
    {"text":"Change password", "color" : Colors.white},
    {"text":"Change image", "color" : Colors.white},
    {"text":"About us", "color" : Colors.white},
    {"text":"FAQ", "color" : Colors.white},
    {"text":"Help", "color" : Colors.white},
    {"text":"Support us", "color" : Colors.white},
    {"text":"Logout", "color" : Colors.red},
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: tileColor,
      child: ListView(
        children: [
            NavItem(text: items[0]["text"], color: items[0]["color"]),
            NavItem(text: items[1]["text"], color: items[1]["color"]),
            NavItem(text: items[2]["text"], color: items[2]["color"]),
            NavItem(text: items[3]["text"], color: items[3]["color"]),
            NavItem(text: items[4]["text"], color: items[4]["color"]),
            NavItem(text: items[5]["text"], color: items[5]["color"]),
            NavItem(text: items[6]["text"], color: items[6]["color"]),
            NavItem(text: items[7]["text"], color: items[7]["color"]),
            NavItem(text: items[8]["text"], color: items[8]["color"]),
        ],
      ),
    );
  }
}

