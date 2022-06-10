import 'dart:convert';

class Task {
  String title;
  String description;
  String createdAt;
  String deadLine;
  int priority;
  bool finished;

  Task({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadLine,
    this.priority = 5,
    this.finished = false,
  });

  static Map<String, Object?> toMap(Task task) {
    return {
      'title': task.title,
      'description': task.description,
      'createdAt': task.createdAt,
      'deadLine': task.deadLine,
      'priority': task.priority,
      'finished': task.finished,
    };
  }

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      description: jsonData["description"],
      title: jsonData["title"],
      deadLine: jsonData["deadLine"],
      createdAt: jsonData["createdAt"],
      priority: jsonData['priority'],
      finished: jsonData["finished"],
    );
  }

  static String encode(List<Task> tasks) {
    return json.encode(tasks.map((e) => Task.toMap(e)).toList());
  }

  static List<Task> decode(String tasks) {
    List encodedList = jsonDecode(tasks) as List<dynamic>;
    List<Task> decodedList =
        encodedList.map<Task>((e) => Task.fromJson(e)).toList();

    decodedList.sort((a, b) {
      DateTime deadLineA = DateTime.parse(a.deadLine);
      DateTime deadLineB = DateTime.parse(b.deadLine);
      return deadLineA.compareTo(deadLineB);
    });

    decodedList.sort((a, b) {
      return a.priority.compareTo(b.priority);
    });

    decodedList.sort(
      (a, b) {
        if (a.finished == b.finished) return 0;
        if (a.finished && !b.finished) return 1;
        return -1;
      },
    );

    return decodedList;
  }
}
