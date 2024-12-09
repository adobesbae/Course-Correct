import 'package:flutter/material.dart';

class Cscone extends StatefulWidget {
  const Cscone({super.key});

  @override
  State<Cscone> createState() => _CsconeState();
}

class _CsconeState extends State<Cscone> {
  @override
  Widget build(BuildContext context) {
    // Define the list of Computer Science 100 Level courses
    final List<String> courses = [
      "Introduction to Computer Science",
      "Fundamentals of Programming",
      "Discrete Mathematics",
      "Introduction to Data Structures",
      "Linear Algebra",
      "General Physics I",
      "General Chemistry I",
      "Technical Writing and Communication",
      "General Biology",
      "Introduction to Statistics",
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
              'Computer Science 100L',
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
              "Courses for Computer Science 100 Level:",
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
