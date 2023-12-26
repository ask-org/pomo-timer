import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer;
  int _totalSeconds = 120;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
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
    _isTimerRunning = !_isTimerRunning;
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _totalSeconds = 120;
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
      backgroundColor: Colors.black,
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
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _resetTimer,
                child: Text('Reset Timer'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
