import 'dart:ui';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:
        SafeArea(
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.topStart,
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/welcome');
                    },
                    child: Icon(
                      Icons.chevron_left_rounded, color: Colors.white38,
                      size: 40.0,)
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25.0, 40, 25.0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    LoginForm(),
                  ],
                ),
              ),

              Expanded(
                // padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 70, //height of button
                            width: double.infinity,
                            child: ElevatedButton.icon(
                                onPressed: () => {},
                                icon: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5.0, 15.0,
                                      5.0),
                                  child: Image(

                                      image: const NetworkImage(
                                          "https://cdn-icons-png.flaticon.com/512/281/281764.png")),
                                ),
                                label: Text(
                                    'Login with Google', style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300,
                                )),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(color: Theme
                                      .of(context)
                                      .primaryColor, width: 2),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                )
                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
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
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: username,
                style: TextStyle(
                  color: Colors.white
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white38,
                          width: 2
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          width: 2
                      )
                  ),
                  labelText: "username",
                  labelStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 22
                  ),
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: password,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white38,
                          width: 2
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          width: 2
                      )
                  ),

                  labelText: "password",
                  labelStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 22
                  ),
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                  onPressed: () => {},

                  child: Text('Login', style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  )),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,65),
                    backgroundColor: Theme
                        .of(context)
                        .primaryColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 14.0),
                  )
              ),
            ],
          ),
        )
    );
  }
}

