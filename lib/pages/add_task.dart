import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomo_timer/models/tasks_model.dart';
import 'package:pomo_timer/models/tasks_service.dart';
import 'package:pomo_timer/pages/set_timer.dart';
import 'package:pomo_timer/widgets/task_list.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TasksService _tasksService = TasksService();

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void openBox() async {
    await Hive.openBox<TaskModel>('taskBox');
  }

  @override
  void initState() {
    super.initState();
    openBox();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: _tasksService.getAllTask(),
            builder: (BuildContext context,
                AsyncSnapshot<List<TaskModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return TaskList(context, deviceHeight, deviceWidth, formatTime,
                    _tasksService);
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
