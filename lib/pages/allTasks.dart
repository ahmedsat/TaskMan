import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskman/Models/task.dart';
import 'package:taskman/utils/constants.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    return FutureBuilder<List<Task>>(
      future: _prefs.then((SharedPreferences prefs) {
        List<Task> tasks = Task.decode(prefs.getString(tasks_key).toString());

        tasks.sort((a, b) {
          DateTime deadLineA = DateTime.parse(a.deadLine);
          DateTime deadLineB = DateTime.parse(b.deadLine);
          return deadLineA.compareTo(deadLineB);
        });

        tasks.sort((a, b) {
          return a.priority!.compareTo(b.priority!);
        });

        return tasks;
      }),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Task>? tasks = snapshot.data;
              return ListView.builder(
                itemCount: tasks?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          tasks![index].title,
                        ),
                        Text(
                          "${tasks[index].priority}",
                        ),
                        Text(
                          tasks[index].deadLine,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
