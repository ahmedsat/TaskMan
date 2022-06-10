import 'package:flutter/material.dart';
import 'package:taskman/Models/task.dart';

class CurrentTask extends StatelessWidget {
  Task task;
  CurrentTask({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Title(
            color: Colors.green,
            child: Text(
              task.title,
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
          ),
          Text("priority : ${task.priority}"),
          Text(task.description),
          Text(task.deadLine),
          Text(task.createdAt),
        ],
      ),
    );
  }
}
