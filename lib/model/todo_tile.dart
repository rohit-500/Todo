import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/edittodo.dart';
import 'package:todo/model/tod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoTile extends StatefulWidget {
  final Todo prod;
  const TodoTile({Key? key, required this.prod}) : super(key: key);

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool? check1 = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // if you need this
          side: BorderSide(
            color: Color.fromARGB(255, 17, 16, 16).withOpacity(0.2),
            width: 1,
          ),
        ),
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        color: Colors.greenAccent,
        child: ListTile(
          leading: Checkbox(
              //only check box
              value: widget.prod.completed, //unchecked
              onChanged: (bool? value) {
                final auth = FirebaseAuth.instance;
                User? user = auth.currentUser;

                setState(() {
                  check1 = value;
                  var obj = {
                    'completed': check1,
                    'content': widget.prod.content,
                    'id': widget.prod.id,
                  };
                  final CollectionReference todocollection =
                      FirebaseFirestore.instance.collection('Todos');
                  todocollection
                      .doc(user!.uid)
                      .collection('todos')
                      .doc(widget.prod.id)
                      .update(obj);
                });
              }),
          title: Column(children: [
            SizedBox(
              height: 10,
            ),
            Text(widget.prod.content),
            SizedBox(
              height: 10,
            ),
          ]),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditTodo(tod: widget.prod)));
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  final auth = FirebaseAuth.instance;
                  User? user = auth.currentUser;
                  final CollectionReference todocollection =
                      FirebaseFirestore.instance.collection('Todos');
                  todocollection
                      .doc(user!.uid)
                      .collection('todos')
                      .doc(widget.prod.id)
                      .delete();
                },
                icon: Icon(Icons.delete))
          ]),
        ),
      ),
    );
  }
}
