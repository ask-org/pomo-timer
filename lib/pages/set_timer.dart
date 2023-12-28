import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetTimer extends StatefulWidget {
  const SetTimer({super.key});

  @override
  State<SetTimer> createState() => SetTimerState();
}

class SetTimerState extends State<SetTimer> {
  TextEditingController taskController = TextEditingController();
  int seconds = 60;

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void saveAndPop(BuildContext context) {
    String task = taskController.text.trim();
    if (seconds >= 60 && task.isNotEmpty) {
      Navigator.pop(context, {'time': seconds, 'task': task});
    } else {
      Navigator.pop(context);
    }
  }

  late SharedPreferences todoTasks;
  getInstance() async {
    todoTasks = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getInstance();
    super.initState();
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double timerFontSize = screenWidth * 0.3;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: ElevatedButton(
          onLongPress: () async {
            await todoTasks.setString("tasks", taskController.text);
          },
          onPressed: () {
            saveAndPop(context);
            log(taskController.text);
            log(seconds.toString());
          },
          child: Text("<"),
        ),
        actions: [
          Text(
            taskController.text,
            style: TextStyle(color: Colors.white),
          )
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
                    if (seconds > 0) {
                      setState(() {
                        seconds -= 60;
                      });
                    }
                  },
                ),
                Text(
                  formatTime(seconds),
                  style:
                      TextStyle(color: Colors.white, fontSize: timerFontSize),
                ),
                TextButton(
                  child: Text(
                    ">",
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  onPressed: () {
                    if (seconds < 99 * 60) {
                      setState(() {
                        seconds += 60;
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
