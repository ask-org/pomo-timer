import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomo_timer/models/tasks_model.dart';
import 'package:pomo_timer/pages/set_timer.dart';

Widget TaskList(BuildContext context, double deviceHeight, double deviceWidth,
    formatTime, _tasksService) {
  return Column(
    children: [
      Container(
        height: 50,
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
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
            valueListenable: Hive.box<TaskModel>('taskBox').listenable(),
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
                            print("deleted");
                          },
                          icon: Icon(Icons.delete)),
                    );
                  });
            }),
      ),
    ],
  );
}
