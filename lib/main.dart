import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pawd/blocs/auth_bloc.dart';
import 'package:pawd/blocs/bloc_observer.dart';
import 'package:pawd/utils/auth_repository.dart';
import 'package:pawd/utils/shared_pref_helper.dart';
import 'package:pawd/views/home.dart';
import 'package:pawd/views/on_boarding.dart';
import 'package:pawd/views/signup.dart';
import 'views/welcome.dart';
import 'views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:pawd/res/colors.dart';
import 'package:pawd/res/sizes.dart';
import 'package:pawd/res/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setSettings(
    appVerificationDisabledForTesting: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super();

  final MaterialColor primaryColor = const MaterialColor(
    primaryColorValue,
    primaryColorMap,
  );

  @override
  void initState() {
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer = SimpleBlocObserver();
    final UserRepository userRepository = UserRepository();
    return BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: userRepository),
        child : MaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/',
          routes: {
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/welcome': (context) => Welcome(),
            '/login': (context) => Login(),
            '/signup': (context) => Signup(),
            '/home' : (context) => Home()
          },
          theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: bgColor,
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                  color: white
              ),
              bodyMedium: TextStyle(color: white30, fontSize: text_md),
            ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
                .copyWith(background: bgColor),
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context,state) {
          return Scaffold(
            body: FutureBuilder(
                future: SharedPrefHelper.hasLoggedIn(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    final hasLoggedIn = snap.data!;
                    if (hasLoggedIn) {
                      // move to home page;
                      return Home();
                    }
                    return OnboardingScreen();
                  }

                  return CircularProgressIndicator();
                }),
          );
        }
      ),
    ));
  }
}
