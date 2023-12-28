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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double timerFontSize = screenWidth * 0.3;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tasks',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        radius: 16,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SetTimer(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tasks[index].title,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                            Text(
                              formatTime(tasks[index].time),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              top: screenHeight * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context, tasks);
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
