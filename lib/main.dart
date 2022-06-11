import 'package:flutter/material.dart';
import 'package:taskman/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskman/Models/task.dart';
import 'package:taskman/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sharing data between screens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

void initPrefs() async {
  List<Task> tasks = [
    // Task(
    //   description: "description 1",
    //   title: "title 1",
    //   createdAt: DateTime.now().toString(),
    //   deadLine: "2022-06-11 16:26:53",
    //   finished: true,
    // ),
    // Task(
    //   description: "description 2",
    //   title: "title 2",
    //   priority: 1,
    //   createdAt: DateTime.now().toString(),
    //   deadLine: "2022-06-12 16:26:53",
    // ),
    // Task(
    //   description: "description 3",
    //   title: "title 3",
    //   createdAt: DateTime.now().toString(),
    //   deadLine: "2022-06-24 16:26:53",
    // ),
    // Task(
    //   description: "description 4",
    //   title: "title 4",
    //   createdAt: DateTime.now().toString(),
    //   deadLine: "2022-06-16 16:26:53",
    // ),
  ];

  String encodedData = Task.encode(tasks);
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  await prefs.setString(tasksKey, encodedData);
}
