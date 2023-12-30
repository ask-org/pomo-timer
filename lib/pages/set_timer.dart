// import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:pomo_timer/models/tasks_model.dart';
import 'package:pomo_timer/models/tasks_service.dart';

class SetTimer extends StatefulWidget {
  const SetTimer({super.key});

  @override
  State<SetTimer> createState() => SetTimerState();
}

class SetTimerState extends State<SetTimer> {
  final TasksService _tasksService = TasksService();
  TextEditingController taskController = TextEditingController();
  int seconds = 60;

  String formatTime(int time) {
    int minutes = time ~/ 60;
    int remainingSeconds = time % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void saveAndPop(BuildContext context) async {
    Navigator.pop(context);
    String title = taskController.text.trim();
    // if (seconds >= 60 && title.isNotEmpty) {
    var tasks =
        TaskModel(time: seconds, title: title.isNotEmpty ? title : 'Untitled');
    await _tasksService.addTask(tasks);
    // }
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double timerFontSize = screenWidth * 0.3;

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   leading: ElevatedButton(
      //     onPressed: () async {
      //       Navigator.pop(context);
      //     },
      //     child: Text(
      //       "<",
      //       style: TextStyle(fontSize: 30),
      //     ),
      //   ),
      //   actions: [
      //     Text(
      //       taskController.text,
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     // save button
      //     IconButton(
      //       icon: const Icon(
      //         Icons.save,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         saveAndPop(context);
      //         log(taskController.text);
      //         log(seconds.toString());
      //       },
      //       // onPressed: () async {
      //       //   if (taskController.text.isNotEmpty) {
      //       //     var tasks = TaskModel(time: time, title: taskController.text);
      //       //     await _tasksService.addTask(tasks);
      //       //   }
      //       //   Navigator.of(context).pop();
      //       // },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        formatTime(seconds),
                        style: TextStyle(
                          fontSize: timerFontSize,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.083,
                      left: screenWidth * 0.03,
                      right: screenWidth * 0.03,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (seconds > 0) {
                                  setState(() {
                                    seconds -= 60;
                                  });
                                }
                              },
                              icon: const Icon(Icons.arrow_left,
                                  color: Colors.white)),
                          IconButton(
                              onPressed: () {
                                if (seconds < 99 * 60) {
                                  setState(() {
                                    seconds += 60;
                                  });
                                }
                              },
                              icon: const Icon(Icons.arrow_right,
                                  color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.8,
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: timerFontSize * 0.2,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                    ),
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
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         TextButton(
          //           child: Text(
          //             "<",
          //             style: TextStyle(color: Colors.white, fontSize: 50),
          //           ),
          //           onPressed: () {
          //             if (seconds > 60) {
          //               setState(() {
          //                 seconds -= 60;
          //               });
          //             }
          //           },
          //         ),
          //         Text(
          //           formatTime(seconds),
          //           style:
          //               TextStyle(color: Colors.white, fontSize: timerFontSize),
          //         ),
          //         TextButton(
          //           child: Text(
          //             ">",
          //             style: TextStyle(color: Colors.white, fontSize: 50),
          //           ),
          //           onPressed: () {
          //             if (seconds < 99 * 60) {
          //               setState(() {
          //                 seconds += 60;
          //               });
          //             }
          //           },
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
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
                      // log(taskController.text);
                      // log(seconds.toString());
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
                      // log(taskController.text);
                      // log(seconds.toString());
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
