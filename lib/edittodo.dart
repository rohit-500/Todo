import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/model/tod.dart';
import 'package:todo/services/auth.dart';
import 'package:todo/services/database.dart';
import 'package:todo/shared/constant.dart';

class EditTodo extends StatefulWidget {
  Todo tod;
  EditTodo({super.key, required this.tod});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  String hascontent = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hascontent = widget.tod.content;
  }

  final auth = FirebaseAuth.instance;
  User? user;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Edit'),
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
                  decoration: textinputdecor,
                  keyboardType: TextInputType.multiline,
                  initialValue: widget.tod.content,
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
                        setState(() {
                          var obj = {
                            'completed': widget.tod.completed,
                            'content': hascontent,
                            'id': widget.tod.id,
                          };
                          final CollectionReference todocollection =
                              FirebaseFirestore.instance.collection('Todos');
                          todocollection
                              .doc(user!.uid)
                              .collection('todos')
                              .doc(widget.tod.id)
                              .update(obj);
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Save",
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
