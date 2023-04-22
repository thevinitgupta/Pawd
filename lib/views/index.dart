
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'hero-image',
            child: SvgPicture.asset(
              'assets/home.svg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'What do you want to do today?',
            style: TextStyle(fontSize: 25, color: Colors.white70),
          ),
          const SizedBox(height: 10,),
          const Text("Tap + to add your tasks",
              style: TextStyle(fontSize: 18, color: Colors.white54))
        ],
      ),
    );
  }
}
