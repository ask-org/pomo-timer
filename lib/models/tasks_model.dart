import 'package:hive/hive.dart';
part 'tasks_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  int time;
  @HiveField(1)
  String title;
  // @HiveField(2, defaultValue: false)
  // String isCompleted;

  TaskModel({
    required this.time,
    required this.title,
    //  required this.isCompleted
  });
}
