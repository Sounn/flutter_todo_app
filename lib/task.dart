import 'package:cloud_firestore/cloud_firestore.dart';
class Task{
  Task(QueryDocumentSnapshot doc){
    // ignore: deprecated_member_use
    documentID = doc.documentID;
    todo = doc['todo'];
  }

  String documentID;
  String todo;
}