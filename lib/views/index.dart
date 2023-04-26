import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawd/res/strings.dart';
import 'package:pawd/res/sizes.dart';

import '../blocs/auth_bloc.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthenticationBloc>();
    final User? user = authBloc.user;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is AuthenticationLoading){
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
                            "Creating User",
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
        if(state is UnAuthenticated){
          Navigator.popUntil(context, (route) => true);
          Navigator.pushNamed(context, "/welcome");
        }
      },
      child: SingleChildScrollView(
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
              'What do you want to do today? ${user?.email}',
              style: TextStyle(fontSize: p_25, color: Colors.white70),
            ),
            ElevatedButton(
                onPressed: () {
                  // RepositoryProvider.of<UserRepository>(context).signInWithCredentials(email.text, password.text),
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationSignedOut());
                },
                child: const Text('Signout',
                    style: TextStyle(
                      fontSize: text_md,
                      fontWeight: FontWeight.w300,
                    )),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, p_65),
                  backgroundColor: Theme
                      .of(context)
                      .primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: p_20, vertical: p_14),
                )),
            const SizedBox(height: p_10,),
            const Text("Tap + to add your tasks",
                style: TextStyle(fontSize: text_sm, color: Colors.white54))
          ],
        ),
      ),
    );
  }
}
