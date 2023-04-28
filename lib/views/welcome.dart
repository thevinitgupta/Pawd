import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pawd/res/colors.dart';
import 'package:pawd/res/sizes.dart';
import 'package:pawd/res/strings.dart';

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
              padding: const EdgeInsets.fromLTRB(p_15, 0, 0, 0),
              child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child : const Icon(Icons.chevron_left_rounded, color: Colors.white38, size: 40.0,)
              ),
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(p_25, p_60, p_25, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome to Pawd",
                        style: TextStyle(
                            fontSize: text_xl, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: p_20),
                      Text(
                        "Please login to your account or create new account to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: text_sm, color: Colors.white54),
                      )
                    ],
                  ),
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: p_40, horizontal: p_25),
              child: Column(
                children: [
                  SizedBox(
                      height:p_70, //height of button
                      width:double.infinity,
                      child : ElevatedButton(
                          onPressed: () => {
                            Navigator.pushReplacementNamed(context, "/login")
                          },
                          child: const Text('LOGIN', style: TextStyle(
                              fontSize: text_lg,
                              fontWeight: FontWeight.w300
                          )),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: p_20, vertical: p_14),
                          )
                      )
                  ),
                  const SizedBox(
                    height: p_20,
                  ),
                  SizedBox(
                      height: p_70, //height of button
                      width:double.infinity,
                      child : ElevatedButton(
                          onPressed: () => {
                            Navigator.pushReplacementNamed(context, "/signup")
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                            padding: const EdgeInsets.symmetric(horizontal: p_20, vertical: p_14),
                          ),
                          child: const Text('CREATE ACCOUNT', style: TextStyle(
                              fontSize: text_lg,
                              fontWeight: FontWeight.w300
                          ))
                      )
                  ),
                  const SizedBox(
                    height: p_20,
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
