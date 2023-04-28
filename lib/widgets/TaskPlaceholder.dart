import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../res/sizes.dart';
import '../res/strings.dart';

class TaskPlaceholder extends StatelessWidget {
  const TaskPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            'What do you want to do today?',
            style: TextStyle(fontSize: p_25, color: Colors.white70),
          ),
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
