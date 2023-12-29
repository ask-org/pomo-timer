import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomo_timer/models/tasks_service.dart';
import 'package:pomo_timer/pages/set_timer.dart';

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
    await Hive.openBox('taskBox');
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
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Container(
                      height: 25,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SetTimer(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: deviceHeight * 0.8,
                      width: deviceWidth * 1,
                      child: ValueListenableBuilder(
                          valueListenable: Hive.box('taskBox').listenable(),
                          builder: (context, box, _) {
                            return ListView.builder(
                                itemCount: box.values.length,
                                itemBuilder: (context, index) {
                                  var tasks = box.getAt(index);
                                  return ListTile(
                                    title: Text(tasks!.title),
                                    leading: Text(formatTime(tasks!.time)),
                                    trailing: IconButton(
                                        onPressed: () {
                                          _tasksService.deleteTask(index);
                                        },
                                        icon: Icon(Icons.delete)),
                                  );
                                });
                          }),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
