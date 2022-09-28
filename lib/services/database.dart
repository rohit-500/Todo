import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/model/tod.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('Todos');
  Future createtodo(String content) async {
    final ref = collection.doc(uid).collection('todos').doc();

    return await ref.set({
      'id': ref.id,
      'completed': false,
      'content': content,
    });
  }

  final CollectionReference todocollection =
      FirebaseFirestore.instance.collection('Todos');
  List<Todo> _prodlistfromsnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((d) {
        return Todo(
          id: d.get('id') ?? "",
          completed: d.get('completed') ?? false,
          content: d.get("content") ?? "",
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Stream<List<Todo>?> get sellerprod {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return todocollection
        .doc(user!.uid)
        .collection('todos')
        .snapshots()
        .map((event) {
      return _prodlistfromsnapshot(event);
    });
  }
}
