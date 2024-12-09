import 'package:course_correct/screens/email_signin.dart';
import 'package:course_correct/screens/signupscreen.dart';
import 'package:flutter/material.dart';
import 'interface.dart';

class LoginScreen extends StatefulWidget {
  // Explicit type annotations
  final TextEditingController? controller; // Can be null since it's optional
  final String hintText;
  final bool obscureText;

  const LoginScreen({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // Ensure items are centered horizontally
                  children: [
                    Image.asset(
                      "assets/images/course.png",
                      scale: 3,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Course Correct',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 41, 40, 40),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Handle sign-in process or navigate to the email sign-in screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmailSignin(
                              obscureText: true,
                              controller: widget.controller,
                              hintext: widget.hintText,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'Sign in with email',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(obscureText: true, hintext: '', controller: null,),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('or sign in with'),
                        const SizedBox(width: 15),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 5,
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  "assets/images/logo3.png",
                                  scale: 370,
                                ),
                              ),
                            ),
                            const SizedBox(width: 23),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          // This part will always be at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 50),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Color(0xFFBDBDBD)),
                    SizedBox(width: 8),
                    CircleAvatar(radius: 4, backgroundColor: Color(0xFFBDBDBD)),
                    SizedBox(width: 8),
                    CircleAvatar(radius: 4, backgroundColor: Color(0xFF424242)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Interface()),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
