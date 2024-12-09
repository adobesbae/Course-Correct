import 'package:course_correct/screens/studyscreen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/welcome.png",
            scale: 3,
          ),
          const SizedBox(height: 3),
          const Text(
            'Welcome to Course Correct',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 41, 40, 40),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          const Text(
            'Programming or Nothing',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 41, 40, 40),
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 50),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Color(0xFF424242)),
                    SizedBox(width: 8),
                    CircleAvatar(radius: 4, backgroundColor: Color(0xFFBDBDBD)),
                    SizedBox(width: 8),
                    CircleAvatar(radius: 4, backgroundColor: Color(0xFFBDBDBD)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Studyscreen()),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      'skip',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
