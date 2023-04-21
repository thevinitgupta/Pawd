import 'dart:ui';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.topStart,
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child : Icon(Icons.chevron_left_rounded, color: Colors.white38, size: 40.0,)
              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(25.0, 60, 25.0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to Pawd",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Please login to your account or create new account to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white54),
                      )
                    ],
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
              child: Column(
                children: [
                  SizedBox(
                      height:70, //height of button
                      width:double.infinity,
                      child : ElevatedButton(
                          onPressed: () => {
                            Navigator.pushReplacementNamed(context, "/login")
                          },
                          child: Text('LOGIN', style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300
                          )),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                          )
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height:70, //height of button
                      width:double.infinity,
                      child : ElevatedButton(
                          onPressed: () => {
                            Navigator.pushReplacementNamed(context, "/signup")
                          },
                          child: Text('CREATE ACCOUNT', style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300
                          )),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                          )
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
