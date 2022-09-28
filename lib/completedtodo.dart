import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/tod.dart';
import 'package:todo/model/todo_tile.dart';

class CompletedTodo extends StatefulWidget {
  const CompletedTodo({Key? key}) : super(key: key);

  @override
  State<CompletedTodo> createState() => _CompletedTodoState();
}

class _CompletedTodoState extends State<CompletedTodo> {
  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<List<Todo>>(context);

    return ListView.builder(
      itemCount: prod.length,
      itemBuilder: (context, index) {
        if (prod[index].completed) {
          return TodoTile(prod: prod[index]);
        } else
          return SizedBox.shrink();
      },
    );
  }
}
