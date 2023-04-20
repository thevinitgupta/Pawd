import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pawd/views/on_boarding.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final Map<int, Color> colorMap = ;

  static const int _primaryColorValue = 0xFF8875FF;
  final MaterialColor primaryColor = const MaterialColor(
    _primaryColorValue,
    const {
      50:  const Color(0xFFE8E7FF),
      100: const Color(0xFFC5C3FF),
      200: const Color(0xFFA29FFF),
      300: const Color(0xFF7E7BFF),
      400: const Color(0xFF5B58FF),
      500: const Color(0xFF3835FF),
      600: const Color(0xFF302ED6),
      700: const Color(0xFF2727AD),
      800: const Color(0xFF1F1F83),
      900: const Color(0xFF17175A),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: primaryColor,
        primaryColor: Color(0xFF8875FF),
        backgroundColor: Color(0x121212),
        scaffoldBackgroundColor: Color(0x121212),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            color: Colors.white30,
            fontSize: 22
          ),
        ),
      ),
      home: const MyHomePage(title: 'Up Todo - Todo List for the Next Gen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingScreen(),
    );
  }
}
