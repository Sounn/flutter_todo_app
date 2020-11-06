import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
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
        '/new': (BuildContext context) => NewTodoPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = List<String>.generate(10, (i) => "ToDo $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context,index){
            return ListTile(
                title: Text('${items[index]}')
              );
            }
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("/new");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class NewTodoPage extends StatefulWidget {
  @override
  _NewTodoPageState createState() => _NewTodoPageState();
}
class _NewTodoPageState extends State<NewTodoPage> {
  String todoText = ''; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新規作成'),
      ),
      body: Container(
        child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: 'やること',
            ),
            // // 複数行のテキスト入力
            // keyboardType: TextInputType.multiline,
            // // 最大3行
            // maxLines: 3,
            onChanged: (String value) {
                todoText = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: ElevatedButton(
              child: Text('作成する'),
              onPressed: () async {
                final date = DateTime.now().toLocal().toIso8601String(); // 現在の日時,後で時間指定出来るようにする
                await FirebaseFirestore.instance
                        .collection('tasks') // コレクションID指定
                        .doc() // ドキュメントID自動生成
                        // ignore: deprecated_member_use
                        .setData({
                          'todo': todoText,
                          'timer': date
                        });// データ
                Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
}

// class _ChangeFormState extends State<ChangeForm> {

//   TimeOfDay _time = new TimeOfDay.now();

//   Future<Null> _selectTime(BuildContext context) async {
//     final TimeOfDay picked = await showTimePicker(
//         context: context,
//         initialTime: _time,
//     );
//     if(picked != null) setState(() => _time = picked);
//   }

//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.all(50.0),
//         child: Column(
//           children: <Widget>[
//             Center(child:Text("${_time}")),
//             new RaisedButton(onPressed: () => _selectTime(context), child: new Text('時間選択'),)
//           ],
//         )
//     );
//   }
// }