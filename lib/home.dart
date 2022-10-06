import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/completedtodo.dart';
import 'package:todo/createtodo.dart';
import 'package:todo/model/tod.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/services/database.dart';
import 'package:todo/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool pending = true;
  final AuthService _auth = AuthService();
  final authuser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = authuser.currentUser;
    return StreamProvider<List<Todo>?>.value(
      value: DatabaseService().sellerprod,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Color.fromARGB(26, 173, 220, 185),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              if (_scaffoldKey.currentState?.isDrawerOpen == false) {
                _scaffoldKey.currentState?.openDrawer();
              } else {
                _scaffoldKey.currentState?.openEndDrawer();
              }
            },
          ),
          backgroundColor: Colors.grey,
          title: Text(
            'Todos',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
        ),
        body: Scaffold(
            drawerScrimColor: Colors.transparent,
            drawerEnableOpenDragGesture: true,
            backgroundColor: Color.fromARGB(26, 173, 220, 185),
            key: _scaffoldKey,
            drawer: Drawer(
                backgroundColor: Color.fromARGB(211, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets\\dp.png"),
                      radius: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${user!.email}',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Divider(
                      color: Colors.white,
                      height: 20,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          if (!pending) pending = true;
                        });
                        Navigator.pop(context);
                      },
                      label: Text(
                        'Pending',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      icon: Icon(Icons.pending_actions),
                    ),
                    Divider(
                      color: Colors.white,
                      height: 20,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          if (pending) pending = false;
                        });
                        Navigator.pop(context);
                      },
                      label: Text(
                        'Completed',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      icon: Icon(Icons.done),
                    ),

                    Spacer(), // us
                    Divider(
                      color: Colors.white,
                    ),
                    TextButton.icon(
                        onPressed: () {
                          _auth.signout();
                        },
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))
                  ],
                )),
            body: pending ? todo_list() : CompletedTodo()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_scaffoldKey.currentState?.isDrawerOpen == true) {
              _scaffoldKey.currentState?.closeDrawer();
            }
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateTodo()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
