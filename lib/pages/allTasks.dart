import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskman/Models/task.dart';
import 'package:taskman/utils/constants.dart';

class AllTasks extends StatelessWidget {
  List<Task>? tasks;
  AllTasks({this.tasks, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return ListView.builder(
      itemCount: tasks?.length,
      itemBuilder: (BuildContext context, int index) {
        print(tasks![index].priority);
        print(tasks![index].finished);
        return ListTile(
          title: Card(
            color: tasks![index].finished ? Colors.green : Colors.red,
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    tasks![index].title,
                  ),
                  Text(
                    "${tasks![index].priority}",
                  ),
                  Text(
                    tasks![index].deadLine,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
