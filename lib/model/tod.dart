import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  late final bool completed;
  final String content;
  final String id;
  Todo({required this.id, required this.completed, required this.content});
  factory Todo.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    print(data);

    return Todo(
        id: data['id'], completed: data['completed'], content: data['content']);
  }
}
