import 'package:flutter/material.dart';

class NationalDiploma extends StatefulWidget {
  const NationalDiploma({super.key});

  @override
  State<NationalDiploma> createState() => _NationalDiplomaState();
}

class _NationalDiplomaState extends State<NationalDiploma> {
  @override
  Widget build(BuildContext context) {
    // Define the list of CSE ND2 courses
    final List<String> courses = [
      "Computer Programming II",
      "Data Structures and Algorithms",
      "Database Management Systems",
      "Computer Networking I",
      "Mathematics for Computing II",
      "Software Engineering Fundamentals",
      "System Analysis and Design",
      "Web Programming and Design",
      "Operating Systems II",
      "Entrepreneurship Studies II",
      "Mobile Application Development I",
      "Web Application Development II",
      "Management Information System",
      "Software Project Management",
      "Information Technology Profession Ethics",
      "Introduction to Multimedia",
      "Computer Application Development",
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
              'National Diploma 2 (CSE)',
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
              "Courses for CSE ND2:",
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
