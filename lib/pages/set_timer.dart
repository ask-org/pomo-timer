import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pomo_timer/models/tasks_model.dart';
import 'package:pomo_timer/models/tasks_service.dart';

class SetTimer extends StatefulWidget {
  const SetTimer({super.key});

  @override
  State<SetTimer> createState() => SetTimerState();
}

class SetTimerState extends State<SetTimer> {
  TasksService _tasksService = TasksService();
  TextEditingController taskController = TextEditingController();
  int time = 60;

  String formatTime(int time) {
    int minutes = time ~/ 60;
    int remainingSeconds = time % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void saveAndPop(BuildContext context) async {
    String title = taskController.text.trim();
    if (time >= 60 && title.isNotEmpty) {
      var tasks = TaskModel(time: time, title: title);
      await _tasksService.addTask(tasks);
      print('Info retrieved from box: $time');
      print('Info retrieved from box: $title');
    } else {
      print("the fuzz there is nothing");
    }
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double timerFontSize = screenWidth * 0.3;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text(
            "<",
            style: TextStyle(fontSize: 30),
          ),
        ),
        actions: [
          Text(
            taskController.text,
            style: TextStyle(color: Colors.white),
          ),
          // save button
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              saveAndPop(context);
              log(taskController.text);
              log(time.toString());
            },
            // onPressed: () async {
            //   if (taskController.text.isNotEmpty) {
            //     var tasks = TaskModel(time: time, title: taskController.text);
            //     await _tasksService.addTask(tasks);
            //   }
            //   Navigator.of(context).pop();
            // },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    "<",
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  onPressed: () {
                    if (time > 0) {
                      setState(() {
                        time -= 60;
                      });
                    }
                  },
                ),
                Text(
                  formatTime(time),
                  style:
                      TextStyle(color: Colors.white, fontSize: timerFontSize),
                ),
                TextButton(
                  child: Text(
                    ">",
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  onPressed: () {
                    if (time < 99 * 60) {
                      setState(() {
                        time += 60;
                      });
                    }
                  },
                ),
              ],
            ),
            Container(
              width: screenWidth * 0.5,
              child: TextFormField(
                  controller: taskController,
                  style: TextStyle(color: Colors.white, fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
