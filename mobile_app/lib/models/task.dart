class TaskModel {
  int? id;
  String task;
  bool done;
String createdAt;
  TaskModel(
      {required this.task,
      required this.done,
      required this.createdAt,
      this.id});  

      factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id']?.toInt(),
        task: json['task'],
        done: json['done'],
        createdAt: json['created_at'],
      );

      Map<String, dynamic> toJson() => {
        'id': id,
        'task': task,
        'done': done,
        'created_at': createdAt,
      };
}
