
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home.dart';
import 'package:todo/model/model.dart';
import 'package:todo/pages/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return home or authenticate
    final user = Provider.of<Usercustom?>(context);

    if (user == null) {
      //if logged out
      return Authenticate();
    } else {
      //if logged in
      return Home();
    }
  }
}
