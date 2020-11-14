import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './task_model.dart';
import './task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskModel>(
      create: (_) => TaskModel()..fetchTasks(),
      child: Scaffold(
            appBar: AppBar(
            title: Text('タスク一覧'),
            ),
            body: Consumer<TaskModel>(
              builder: (context, model, child) {
                final tasks = model.tasks;
                final listTiles = tasks
                  .map(
                    (task) => Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(task.todo),
                          onTap: (){
                            Navigator.of(context).pushNamed("/update", arguments: task);
                          },
                        ),
                      ),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: '消去',
                        color: Colors.red,
                        icon: Icons.delete_forever_outlined,
                        onTap: () {
                          updateTask(task, context);
                          Navigator.of(context).pushNamed("/home");
                        },
                      ),
                    ],
                  ),
                  ).toList();
                return ListView(
                  children: listTiles,
                ); 
              },
            ),
      ),
    );
  }
  Future updateTask(Task task,BuildContext context) async {
    final document = FirebaseFirestore.instance.collection('tasks').doc(task.documentID);
    await document.delete();
  }
}

