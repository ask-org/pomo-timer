import 'package:hive/hive.dart';
import 'package:pomo_timer/models/tasks_model.dart';

class TasksService {
  final String _boxName = "taskBox";
  Future<Box<TaskModel>> get _box async =>
      await Hive.openBox<TaskModel>(_boxName);

  Future<void> addTask(TaskModel taskModel) async {
    var box = await _box;
    await box.add(taskModel);
  }

  Future<List<TaskModel>> getAllTask() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteTask(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future<void> updateTask(int index, TaskModel taskModel) async {
    var box = await _box;
    await box.putAt(index, taskModel);
  }

  // Future<void> updateTask (int index, TaskModel taskModel) async {
  //   var box = await _box;
  //   taskModel.isCompleted = !taskModel.isCompleted;
  //   await box.putAt(index, taskModel);
  // }
}
