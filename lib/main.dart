import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomo_timer/models/tasks_model.dart';
import 'package:pomo_timer/time.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  // await Hive.openBox<TaskModel>("taskBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimerPage(),
    );
  }
}
