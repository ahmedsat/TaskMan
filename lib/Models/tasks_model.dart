class Task {
  String id;
  String title;
  String description;
  String createdAt;
  String deadLine;
  int priority;
  bool finished;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadLine,
    this.priority = 5,
    this.finished = false,
  });

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      id: jsonData["id"],
      title: jsonData["title"],
      description: jsonData["description"],
      deadLine: jsonData["deadLine"],
      createdAt: jsonData["createdAt"],
      priority: jsonData['priority'],
      finished: jsonData["finished"],
    );
  }
}
