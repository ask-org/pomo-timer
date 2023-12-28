import 'package:flutter/material.dart';
import 'package:pomo_timer/models/tasks_model.dart';
import 'package:pomo_timer/pages/set_timer.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late List<TaskModel> tasks = [
    TaskModel(time: 20, title: 'Task 1'),
    TaskModel(time: 30, title: 'Task 2'),
    TaskModel(time: 40, title: 'Task 3'),
    TaskModel(time: 50, title: 'Task 4'),
    TaskModel(time: 60, title: 'Task 5'),
    TaskModel(time: 20, title: 'Task 1'),
    TaskModel(time: 30, title: 'Task 2'),
    TaskModel(time: 40, title: 'Task 3'),
    TaskModel(time: 50, title: 'Task 4'),
    TaskModel(time: 60, title: 'Task 5'),
    TaskModel(time: 20, title: 'Task 1'),
    TaskModel(time: 30, title: 'Task 2'),
    TaskModel(time: 40, title: 'Task 3'),
    TaskModel(time: 50, title: 'Task 4'),
    TaskModel(time: 60, title: 'Task 5'),
  ];

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, tasks);
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SetTimer(),
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Time: ${formatTime(tasks[index].time)},    Task: ${tasks[index].title}',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
