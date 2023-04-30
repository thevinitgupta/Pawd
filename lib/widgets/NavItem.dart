import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawd/blocs/auth_bloc.dart';
import 'package:pawd/res/sizes.dart';

class NavItem extends StatefulWidget {
  final String text;
  final Color color;

  const NavItem({Key? key, required this.text, required this.color}) : super(key: key);

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return TextButton(
      onPressed: () {
        if(widget.text=="Logout"){
          authBloc.add(AuthenticationSignedOut());
        }
      },
      child: Container(
        padding: const EdgeInsets.all(p_15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.text, style: TextStyle(
              fontSize: text_sm,
              color: widget.color
            ),),
            Icon(
              EvaIcons.arrowRight,
              color: widget.color,
            )
          ],
        ),
      ),
    );
  }
}
