import 'package:course_correct/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required bool obscureText,
    required String hintext,
    required controller,
  });

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign-up state variables
  String? signUpError;
  bool signUpSuccess = false;

  // Sign user up
  Future<void> signUserUp() async {
    // Show loading circle
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog manually
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Check if passwords match
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        signUpError = "Passwords do not match!";
      });
      if (mounted) Navigator.pop(context); // Close the loading dialog safely
      return;
    }

    try {
      // Sign up the user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context); // Dismiss the loading dialog
        setState(() {
          signUpSuccess = true; // Update success state
        });
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Dismiss the loading dialog safely
        setState(() {
          signUpError = "Failed to sign up: ${e.toString()}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show success message if sign-up was successful
    if (signUpSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Display success SnackBar
        String? userEmail = FirebaseAuth.instance.currentUser?.email;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign Up successful! Welcome, $userEmail")),
        );

        // Reset form fields after sign-up
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
      });
    }

    // Show error message if there's an error
    if (signUpError != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(signUpError!)),
        );
        signUpError = null; // Reset error to avoid repeated SnackBars
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
              const SizedBox(height: 30.0),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Sign up to access Course Correct.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 16.0),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: signUserUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade600,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate to Login Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(
                          obscureText: true,
                          hintText: '',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Click if you already have an account?",
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
