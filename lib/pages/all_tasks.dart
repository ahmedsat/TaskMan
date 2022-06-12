import 'package:flutter/material.dart';
import 'package:taskman/Models/tasks_model.dart';
import 'package:taskman/controllers/tasks_controler.dart';
import 'package:taskman/pages/no_tasks_here.dart';

class AllTasks extends StatelessWidget {
  final Function() notifyParent;
  List<Task>? tasks;
  TasksController tc = TasksController.instance;
  AllTasks({this.tasks, Key? key, required this.notifyParent})
      : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  IconButton(
                    onPressed: () async {
                      await tc.deleteTask(tasks![index].id);
                      notifyParent();
                    },
                    icon: const Icon(Icons.delete),
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
