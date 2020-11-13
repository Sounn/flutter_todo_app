import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task.dart';

class TaskEditPage extends StatefulWidget {
  @override
  _TaskEditPageState createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  String todoText = ''; 

  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context).settings.arguments;
    final textEditingController = TextEditingController();
    textEditingController.text = task.todo;
    return Scaffold(
      appBar: AppBar(
        title: Text('編集'),
      ),
      body: Container(
        child: Column(
        children: <Widget>[
          TextFormField(
            controller: textEditingController,
            enabled: true,
            decoration: InputDecoration(
              hintText: 'やることを入力してください',
              icon: Icon(Icons.work),
              labelText: 'やること *',
            ),
            onChanged: (String value) {
                todoText = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: ElevatedButton(
              child: Text('更新する'),
              onPressed: () async {
                await updateTask( task, context);
                  Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
                
  Future updateTask(Task task,BuildContext context) async {
    final document = FirebaseFirestore.instance.collection('tasks').doc(task.documentID);
    await document.update(
      {
        'todo': todoText,
        'timer':Timestamp.now(),
      },
    );
  }
}