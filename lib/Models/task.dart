import 'dart:convert';

class Task {
  String title;
  String description;
  String createdAt;
  String deadLine;
  int? priority;

  Task({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadLine,
    this.priority = 5,
  });

  static Map<String, Object?> toMap(Task task) {
    return {
      'title': task.title,
      'description': task.description,
      'createdAt': task.createdAt,
      'deadLine': task.deadLine,
      'priority': task.priority,
    };
  }

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
        description: jsonData["description"],
        title: jsonData["title"],
        deadLine: jsonData["deadLine"],
        createdAt: jsonData["createdAt"],
        priority: jsonData['priority']);
  }

  static String encode(List<Task> tasks) {
    return json.encode(tasks.map((e) => Task.toMap(e)).toList());
  }

  static List<Task> decode(String tasks) {
    List decodedList = jsonDecode(tasks) as List<dynamic>;
    return decodedList.map<Task>((e) => Task.fromJson(e)).toList();
  }
}
