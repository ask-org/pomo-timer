import 'package:flutter/material.dart';
import 'package:pomo_timer/time.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TimerPage()));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.42,
              width: screenWidth * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/time_untill.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              "By",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              height: screenHeight * 0.26,
              width: screenWidth * 0.56,
              child: Image.asset(
                "assets/images/ask_dev.jpeg",
                fit: BoxFit.fill,
              ),
              // child: Text("ASK DEV",
              //     style: TextStyle(color: Colors.white, fontSize: 20)),
            )
          ],
        ),
      ),
    );
    ;
  }
}
