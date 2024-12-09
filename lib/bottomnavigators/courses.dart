import 'package:course_correct/pages/coursespage/cscfour.dart';
import 'package:course_correct/pages/coursespage/cscone.dart';
import 'package:course_correct/pages/coursespage/cscthree.dart';
import 'package:course_correct/pages/coursespage/csctwo.dart';
import 'package:course_correct/pages/coursespage/nationaldiploma.dart';
import 'package:course_correct/pages/coursespage/nationaldiplomaone.dart';
import 'package:flutter/material.dart';


class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MenuButton(
              icon: Icons.school,
              label: 'National diploma CSE 100L',
              iconColor: Colors.grey,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NationalDiplomaOne()),
                );
              },
            ),
            MenuButton(
              icon: Icons.school,
              label: 'National diploma CSE 200L',
              iconColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NationalDiploma()),
                );
              },
            ),
            MenuButton(
              icon: Icons.school,
              label: 'Computer science 100L',
              iconColor: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cscone()),
                );
              },
            ),
            MenuButton(
              icon: Icons.school,
              label: 'Computer science 200L',
              iconColor: Colors.yellow,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Csctwo()),
                );
              },
            ),
            MenuButton(
              icon: Icons.school,
              label: 'Computer science 300L',
              iconColor: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cscthree()),
                );
              },
            ),
            MenuButton(
              icon: Icons.school,
              iconColor: Colors.red,
              label: 'Computer science 400L',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cscfour()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const MenuButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap,
      this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade700,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(label, style: const TextStyle(color: Colors.white)),
          onTap: onTap,
        ),
      ),
    );
  }
}
