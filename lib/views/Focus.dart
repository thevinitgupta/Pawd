import 'package:flutter/material.dart';
import 'package:pawd/widgets/Timer.dart';

class Focus extends StatefulWidget {
  const Focus({Key? key}) : super(key: key);

  @override
  State<Focus> createState() => _FocusState();
}

class _FocusState extends State<Focus> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Timer(),
    );
  }
}
