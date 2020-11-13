import './task_list_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'task_edit_page.dart';
import './task_new_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => MyHomePage(),
        '/new': (BuildContext context) => TaskNewPage(),
        '/update': (BuildContext context) => TaskEditPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todos'),
      ),
      body: TaskListPage(),
      floatingActionButton: FloatingActionButton( //todo作成ボタン
        onPressed: (){
          Navigator.of(context).pushNamed("/new");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}