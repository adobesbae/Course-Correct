import 'package:flutter/material.dart';

class NationalDiplomaOne extends StatefulWidget {
  const NationalDiplomaOne({super.key});

  @override
  State<NationalDiplomaOne> createState() => _NationalDiplomaOneState();
}

class _NationalDiplomaOneState extends State<NationalDiplomaOne> {
  @override
  Widget build(BuildContext context) {
    // Define the list of ND1 courses
    final List<String> courses = [
      "Introduction to Computer Science",
      "Mathematics for Computing",
      "Digital Logic and Design",
      "Programming Fundamentals",
      "Data Structures and Algorithms",
      "Basic Electronics",
      "Communication Skills",
      "Operating Systems",
      "Entrepreneurship Studies",
      "Introduction to Internet and Web Technology",
      "Computer Hardware and Maintenance",
      
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.2), // Shadow color with transparency
                offset:
                    const Offset(0, 4), // Horizontal and vertical shadow offset
                blurRadius: 8.0, // Softness of the shadow
              ),
            ],
          ),
          child: AppBar(
            title: const Text(
              'National Diploma 1 (CSE)',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  size: 15, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0, // Disable default shadow
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Courses for ND1:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Dynamically display the list of courses
            ...courses.map((course) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "- $course",
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
