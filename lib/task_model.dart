import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './task.dart';

class TaskModel extends ChangeNotifier {
  List<Task> tasks = [];
  String todoText = ''; 

  Future fetchTasks() async {
    // ignore: deprecated_member_use
    final docs = await FirebaseFirestore.instance.collection('tasks').getDocuments();
    // ignore: deprecated_member_use
    final tasks = docs.documents.map((doc) => Task(doc)).toList();
    this.tasks = tasks;
    notifyListeners();
  }
}