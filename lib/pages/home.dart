import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskman/Models/tasks_model.dart';
import 'package:taskman/controllers/tasks_controler.dart';
import 'package:taskman/pages/all_tasks.dart';
import 'package:taskman/pages/current_task.dart';
import 'package:taskman/pages/no_tasks_here.dart';
import 'package:taskman/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _selectedIndex = 0;
  List<Task>? tasks;
  TasksController tc = TasksController.instance;

  static final List<Widget> _widgetOptions = <Widget>[
    // const CircularProgressIndicator(),
    // const CircularProgressIndicator(),
    const NoTasksHere(),
    const NoTasksHere(),
    const CircularProgressIndicator(),
    const NoTasksHere(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<List<Task>>(
          future: tc.tasks,
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.data!.isNotEmpty) {
              tasks = snapshot.data;
              _widgetOptions[0] = CurrentTask(task: tasks![0]);
              _widgetOptions[1] = AllTasks(
                notifyParent: refresh,
                tasks: tasks,
              );
            }
            return _widgetOptions.elementAt(_selectedIndex);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Task',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
