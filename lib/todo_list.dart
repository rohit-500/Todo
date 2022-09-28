import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/tod.dart';
import 'package:todo/model/todo_tile.dart';

class todo_list extends StatefulWidget {
  const todo_list({Key? key}) : super(key: key);

  @override
  State<todo_list> createState() => _todo_listState();
}

class _todo_listState extends State<todo_list> {
  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<List<Todo>>(context);

    return ListView.builder(
      itemCount: prod.length,
      itemBuilder: (context, index) {
        if (!prod[index].completed) {
          return TodoTile(prod: prod[index]);
        } else
          return SizedBox.shrink();
      },
    );
  }
}
