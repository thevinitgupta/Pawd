import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../res/sizes.dart';

class NavButton extends StatelessWidget {
  const NavButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        EvaIcons.menu2,
        color: Colors.white,
        size: p_35,
      ), onPressed: () {
      return Scaffold.of(context).openDrawer();
    },
    );
  }
}
