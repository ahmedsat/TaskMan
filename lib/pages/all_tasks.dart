import 'package:flutter/material.dart';
import 'package:taskman/Models/task.dart';
import 'package:taskman/pages/no_tasks_here.dart';

class AllTasks extends StatelessWidget {
  List<Task>? tasks;
  AllTasks({this.tasks, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tasks!.isEmpty) return const NoTasksHere();
    return ListView.builder(
      itemCount: tasks?.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Card(
            color: tasks![index].finished ? Colors.green : Colors.red,
            child: SizedBox(
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
