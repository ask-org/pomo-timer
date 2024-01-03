import 'package:flutter/material.dart';
import 'package:pomo_timer/time.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var textColor = Colors.white;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: screenHeight * 0.05),
            child: Column(children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TimerPage(),
                        ),
                      );
                    },
                  ),
                  Text(
                    "About",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: screenHeight * 0.13,
                            width: screenWidth * 0.28,
                            child: Image.asset(
                              "assets/images/time_untill_small.png",
                              fit: BoxFit.fill,
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Time Untill \nBy ASK Dev",
                          style: TextStyle(color: textColor, fontSize: 25),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: textColor,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Row(
                          children: [
                            Text(
                              "version",
                              style: TextStyle(color: textColor, fontSize: 20),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "0.4",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 28,
                          width: 28,
                          child: Image.network(
                              'https://avatars.githubusercontent.com/u/9919?s=280&v=4'),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Source code",
                          style: TextStyle(color: textColor, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.mail,
                          color: textColor,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Feedback",
                          style: TextStyle(color: textColor, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: textColor,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Rate this app",
                          style: TextStyle(color: textColor, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.file_download,
                          color: textColor,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Other apps",
                          style: TextStyle(color: textColor, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.web,
                          color: textColor,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Visit our website",
                          style: TextStyle(color: textColor, fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
