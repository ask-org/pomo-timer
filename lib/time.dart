import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomo_timer/pages/add_task.dart';

class TimerPage extends StatefulWidget {
  // take a few other parameters like title, description, etc. in the constructor
  const TimerPage({this.task, this.time}) : super(key: null);
  // const TimerPage({Key? key}) : super(key: key);
  final String? task;
  final int? time;

  @override
  // ignore: library_private_types_in_public_api
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer;
  static const _defaultTime = 2000;
  int _totalSeconds = 0;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.time ?? _defaultTime;
  }

  void _toggleTimer() {
    if (_isTimerRunning) {
      _timer.cancel();
    } else {
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(oneSec, (Timer timer) {
        setState(() {
          if (_totalSeconds == 0) {
            timer.cancel();
            _isTimerRunning = false;
          } else {
            _totalSeconds--;
          }
        });
      });
    }
    setState(() {
      _isTimerRunning = !_isTimerRunning;
    });
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _totalSeconds = _defaultTime;
      _isTimerRunning = false;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, "0")}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double timerFontSize = screenWidth * 0.3;

    return Scaffold(
      backgroundColor: _isTimerRunning
          ? Colors.black
          : const Color.fromARGB(255, 35, 43, 43),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _toggleTimer,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      _formatTime(_totalSeconds),
                      style: TextStyle(
                        fontSize: timerFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Align(
                //   alignment: Alignment.center,
                //   child: ElevatedButton(
                //     onPressed: _resetTimer,
                //     style: ElevatedButton.styleFrom(
                //       textStyle: const TextStyle(fontWeight: FontWeight.normal),
                //     ),
                //     child: const Text('Reset Timer'),
                //   ),
                // ),
              ],
            ),
          ),
          Positioned(
            right: screenWidth * 0.05,
            top: screenHeight * 0.06,
            child: _isTimerRunning == false
                ? IconButton(
                    icon: CircleAvatar(
                      backgroundColor: Colors.grey[900],
                      radius: 20,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddTask(),
                        ),
                      );
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
