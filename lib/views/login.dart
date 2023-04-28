import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawd/res/colors.dart';
import 'package:pawd/res/sizes.dart';
import 'package:pawd/res/strings.dart';
import 'package:pawd/utils/auth_repository.dart';
import 'package:pawd/views/index.dart';

import '../blocs/auth_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
      if (state is AuthenticationLoading) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return WillPopScope(
                onWillPop: () {
                  return Future.value(false);
                },
                child: Dialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, top: 12, right: 18, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Logging In",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        CircularProgressIndicator()
                      ],
                    ),
                  ),
                ),
              );
            });
      }
        if (state is AuthenticationSuccess) {
          print(state.firebaseUser.email);
          Navigator.popUntil(context, (route) => true);
          Navigator.pushNamed(context, "/home");
        }
        if (state is AuthenticationFailure) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Error Signing In"),
                  content: Text(state.errorMessage),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text("Retry")),
                  ],
                );
              });
        }
      },
        child: RepositoryProvider(
        create: (context) => UserRepository(),
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      padding: const EdgeInsets.fromLTRB(p_15, 0, 0, 0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/welcome');
                          },
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.white38,
                            size: p_40,
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(p_25, p_40, p_25, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: text_xl,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: p_20),
                          const LoginForm(),
                        ],
                      ),
                    ),
                    Expanded(
                        // padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: p_20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: p_70, //height of button
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                  onPressed: () => {},
                                  icon: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0, p_5, p_15, p_5),
                                    child: Image(
                                        image: NetworkImage(
                                            "https://cdn-icons-png.flaticon.com/512/281/281764.png")),
                                  ),
                                  label: const Text('Login with Google',
                                      style: TextStyle(
                                        fontSize: text_md,
                                        fontWeight: FontWeight.w300,
                                      )),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: p_20, vertical: p_14),
                                  ))),
                          const SizedBox(
                            height: p_20,
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              )),
        )
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || !emailRegex.hasMatch(value)) {
                    return emailString;
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: email,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2)),
                  labelText: "Email",
                  labelStyle:
                  const TextStyle(color: Colors.white38, fontSize: text_md),
                ),
              ),
              const SizedBox(
                height: p_30,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return passwordStrings[0];
                  } else if (value.length < 8) {
                    return passwordStrings[1];
                  } else if (!passwordRegex.hasMatch(value)) {
                    return passwordStrings[2];
                  }
                  return null;
                },
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                controller: password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2)),
                  labelText: "Password",
                  labelStyle:
                  const TextStyle(color: Colors.white38, fontSize: text_md),
                ),
              ),
              const SizedBox(
                height: p_30,
              ),
              ElevatedButton(
                  onPressed: () {
                    // RepositoryProvider.of<UserRepository>(context).signInWithCredentials(email.text, password.text),
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(SendLoginRequest(email.text, password.text));
                  },
                  child: const Text('Login',
                      style: TextStyle(
                        fontSize: text_md,
                        fontWeight: FontWeight.w300,
                      )),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, p_65),
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: p_20, vertical: p_14),
                  )),
            ],
          ),
        ));
  }
}
