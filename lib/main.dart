import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pawd/utils/shared_pref_helper.dart';
import 'package:pawd/views/on_boarding.dart';
import 'package:pawd/views/signup.dart';
import 'views/welcome.dart';
import 'views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  static const int _primaryColorValue = 0xFF8875FF;
  final MaterialColor primaryColor = const MaterialColor(
    _primaryColorValue,
    const {
      50: const Color(0xFFE8E7FF),
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

  @override
  void initState() {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/welcome': (context) => Welcome(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
      },
      theme: ThemeData(
        primarySwatch: primaryColor,
        primaryColor: Color(0xFF8875FF),
        backgroundColor: Color(0x121212),
        scaffoldBackgroundColor: Color(0x121212),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          bodyText2: TextStyle(color: Colors.white30, fontSize: 22),
        ),
      ),
      home: const MyHomePage(title: 'Pawd - Todo List for the Next Gen'),
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
      body: FutureBuilder(
          future: SharedPrefHelper.hasLoggedIn(),
          builder: (context, snap) {
            if (snap.hasData) {
              final hasLoggedIn = snap.data!;
              if (hasLoggedIn) {
                // move to home page;
                return Container();
              }
              return OnboardingScreen();
            }

            return CircularProgressIndicator();
          }),
    );
  }
}
