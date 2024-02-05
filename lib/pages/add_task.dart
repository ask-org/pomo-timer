import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomo_timer/models/tasks_model.dart';
import 'package:pomo_timer/models/tasks_service.dart';
import 'package:pomo_timer/pages/set_timer.dart';
import 'package:pomo_timer/time.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.15,
                  bottom: screenHeight * 0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tasks",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SetTimer(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  SingleChildScrollView(
                    child: FutureBuilder(
                        future: _tasksService.getAllTask(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TaskModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.65,
                                  // color: Colors.blue,
                                  width: screenWidth * 1,
                                  child: ValueListenableBuilder(
                                      valueListenable:
                                          Hive.box<TaskModel>('taskBox')
                                              .listenable(),
                                      builder: (context, box, _) {
                                        return ListView.builder(
                                            itemCount: box.values.length,
                                            itemBuilder: (context, index) {
                                              var tasks = box.getAt(index);
                                              return Dismissible(
                                                background: Container(
                                                  color: Color.fromARGB(255, 158, 142, 140),
                                                ),
                                                key: ValueKey(index),
                                                onDismissed: (DismissDirection
                                                    direction) {
                                                  setState(() {
                                                    _tasksService
                                                        .deleteTask(index);
                                                  });
                                                },
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TimerPage(
                                                          task: tasks.title,
                                                          time: tasks.time,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: ListTile(
                                                    title: Text(tasks!.title,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        )),
                                                    leading: Text(
                                                        formatTime(tasks.time),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              );
                                            });
                                      }),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
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
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
}
