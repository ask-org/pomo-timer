import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomo_timer/models/tasks_model.dart';
import 'package:pomo_timer/pages/add_task.dart';
import 'package:pomo_timer/pages/set_timer.dart';
import 'package:pomo_timer/time.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SetTimer(),
    );
  }
}
