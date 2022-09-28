import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/services/database.dart';
import 'package:todo/shared/constant.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final auth = FirebaseAuth.instance;
  User? user;
  final _formkey = GlobalKey<FormState>();
  String hascontent = "";
  @override
  Widget build(BuildContext context) {
    user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Create a Todo'),
      ),
      backgroundColor: Color.fromARGB(88, 78, 84, 73),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: textinputdecor.copyWith(hintText: 'Todo'),
                  validator: (val) => val!.isEmpty ? 'Cannot be empty' : null,
                  onChanged: (val) {
                    setState(() {
                      hascontent = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(15),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.grey),
                      minimumSize:
                          MaterialStateProperty.all(const Size(100, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red))),
                      shadowColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await DatabaseService(uid: user!.uid)
                            .createtodo(hascontent);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
 
}
