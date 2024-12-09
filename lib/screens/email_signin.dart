import 'package:course_correct/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailSignin extends StatefulWidget {
  const EmailSignin(
      {super.key,
      required bool obscureText,
      required String hintext,
      required controller});

      

  @override
  EmailSigninState createState() => EmailSigninState();
}

class EmailSigninState extends State<EmailSignin> {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign user in without using BuildContext across async gaps
  Future<void> signUserIn() async {
    // show login circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      // Sign in the user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Once signed in, we can show the SnackBar and navigate in the build method
      setState(() {
        signInSuccess = true; // Update UI based on success
      });
    } catch (e) {
      setState(() {
        signInError = "Failed to sign in: ${e.toString()}"; // Capture error
      });
    }
  }

  String? signInError;
  bool signInSuccess = false;

  @override
  Widget build(BuildContext context) {
    if (signInSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Show success message with the email of the signed-in user
        String? userEmail = FirebaseAuth.instance.currentUser?.email;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign in successful! Welcome, $userEmail"),),
        );

        // Navigate to the home screen after successful sign-in
        Navigator.pushReplacementNamed(context, '/interface');
      });
    }

    if (signInError != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(signInError!)),
        );
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150.0,
                  height: 150.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Sign in to access Course Correct.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    signUserIn(); // Remove context from async method
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade600,
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Login Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(
                          obscureText: true,
                          hintText: '',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Click if you don't have an account?",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
