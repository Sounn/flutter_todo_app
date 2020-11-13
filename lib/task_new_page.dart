import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskNewPage extends StatefulWidget {
  @override
  _TaskNewPageState createState() => _TaskNewPageState();
}
class _TaskNewPageState extends State<TaskNewPage> {
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
            enabled: true,
            decoration: InputDecoration(
              hintText: 'やることを入力してください',
              icon: Icon(Icons.work),
              labelText: 'やること *',
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