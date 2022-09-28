
import 'package:flutter/material.dart';
import 'package:todo/pages/register.dart';
import 'package:todo/pages/sigin.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = true;
  void toggleView() {
    setState(() {
      showsignin = !showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showsignin
          ? SignIn(toggleView: toggleView)
          : Register(toggleView: toggleView),
    );
  }
}
