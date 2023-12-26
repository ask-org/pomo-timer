import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer;
  final int _defaultTime = 1200;
  int _totalSeconds = 0;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _totalSeconds = _defaultTime;
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
    double timerFontSize = screenWidth * 0.3;

    return Scaffold(
      backgroundColor:
          _isTimerRunning ? Colors.black : Color.fromARGB(255, 35, 43, 43),
      body: Center(
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
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _resetTimer,
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontWeight: FontWeight.normal),
                ),
                child: const Text('Reset Timer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
