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

  var timer;

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double timerFontSize = screenWidth * 0.3;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (seconds > 0) {
                            setState(() {
                              seconds -= 60;
                            });
                          }
                        },
                        icon:
                            const Icon(Icons.arrow_left, color: Colors.white)),
                    Text(
                      formatTime(seconds),
                      style: TextStyle(
                        fontSize: timerFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    // tif someone clicks on the arrow it will add 60 seconds, holding the button will keep increasing 60 seconds every 0.5 seconds only if the button is held
                    IconButton(
                        onPressed: () {
                          if (seconds < 99 * 60) {
                            setState(() {
                              seconds += 60;
                            });
                          }
                        },
                        icon:
                            const Icon(Icons.arrow_right, color: Colors.white)),
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter task',
                      hintStyle: TextStyle(
                        fontSize: timerFontSize * 0.2,
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    controller: taskController,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      log(taskController.text);
                      log(seconds.toString());
                    },
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
                      log(seconds.toString());
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
