import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskman/Models/tasks_model.dart';
import 'package:taskman/utils/constants.dart';

class TasksController {
  TasksController._privateConstructor();

  static final TasksController _instance =
      TasksController._privateConstructor();

  Future<List<Task>> get tasks async {
    List<Task> tasks = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tasks = TasksController.decode(prefs.getString(tasksKey).toString());
    return tasks;
  }

  static TasksController get instance => _instance;

  static Map<String, Object?> toMap(Task task) {
    return {
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'createdAt': task.createdAt,
      'deadLine': task.deadLine,
      'priority': task.priority,
      'finished': task.finished,
    };
  }

  static String encode(List<Task> tasks) {
    return json.encode(tasks.map((e) => TasksController.toMap(e)).toList());
  }

  static List<Task> decode(String tasks) {
    List encodedList = jsonDecode(tasks) as List<dynamic>;
    List<Task> decodedList =
        encodedList.map<Task>((e) => Task.fromJson(e)).toList();
    decodedList = sort(decodedList);
    return decodedList;
  }

  static List<Task> sort(List<Task> tasks) {
    tasks.sort((a, b) {
      DateTime deadLineA = DateTime.parse(a.deadLine);
      DateTime deadLineB = DateTime.parse(b.deadLine);
      return deadLineA.compareTo(deadLineB);
    });

    tasks.sort((a, b) {
      return a.priority.compareTo(b.priority);
    });

    tasks.sort(
      (a, b) {
        if (a.finished == b.finished) return 0;
        if (a.finished && !b.finished) return 1;
        return -1;
      },
    );
    return tasks;
  }

  Future<void> deleteTask(String id) async {
    List<Task> tasks = await _instance.tasks;
    List<Task> newTasks = [];
    for (var task in tasks) {
      if (task.id != id) {
        newTasks.add(task);
      }
    }
    await update(newTasks);
  }

  Future<void> update(List<Task> tasks) async {
    String encodedData = TasksController.encode(tasks);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tasksKey);
    await prefs.setString(tasksKey, encodedData);
  }
}
