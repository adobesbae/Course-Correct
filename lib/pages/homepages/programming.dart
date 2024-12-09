import 'package:flutter/material.dart';

class ProgrammingPage extends StatelessWidget {
  const ProgrammingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of programming languages
    final List<Map<String, dynamic>> programmingLanguages = [
      {'icon': Icons.code, 'label': 'Python'},
      {'icon': Icons.code, 'label': 'JavaScript'},
      {'icon': Icons.code, 'label': 'Java'},
      {'icon': Icons.code, 'label': 'C++'},
      {'icon': Icons.code, 'label': 'C#'},
      {'icon': Icons.code, 'label': 'PHP'},
      {'icon': Icons.code, 'label': 'Swift'},
      {'icon': Icons.code, 'label': 'Kotlin'},
      {'icon': Icons.code, 'label': 'Ruby'},
      {'icon': Icons.code, 'label': 'Go (Golang)'},
      {'icon': Icons.code, 'label': 'R'},
      {'icon': Icons.code, 'label': 'Structured Query Language'},
      {'icon': Icons.code, 'label': 'Rust'},
      {'icon': Icons.code, 'label': 'TypeScript'},
      {'icon': Icons.code, 'label': 'MATLAB'},
      {'icon': Icons.code, 'label': 'Scala'},
      {'icon': Icons.code, 'label': 'Shell (Bash, PowerShell)'},
      {'icon': Icons.code, 'label': 'Perl'},
      {'icon': Icons.code, 'label': 'Dart'},
      {'icon': Icons.code, 'label': 'HTML/CSS (Web Content)'},
      {'icon': Icons.code, 'label': 'Objective-C'},
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
              'Programming Languages',
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
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: programmingLanguages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  leading: Icon(
                    programmingLanguages[index]['icon'],
                    color: Colors.white,
                  ),
                  title: Text(
                    programmingLanguages[index]['label'],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
