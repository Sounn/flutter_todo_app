import 'package:flutter/material.dart';
import './task_model.dart';
import 'package:provider/provider.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskModel>(
      create: (_) => TaskModel()..fetchTasks(),
      child: Scaffold(
            body: Consumer<TaskModel>(
              builder: (context, model, child) {
                final tasks = model.tasks;
                final listTiles = tasks
                  .map(
                    (task) => ListTile(
                      title: Text(task.todo),
                      onTap: (){
                        Navigator.of(context).pushNamed("/update", arguments: task);
                      }
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
}

