import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bottomnavigators/courses.dart';
import '../bottomnavigators/reminder.dart';
import '../bottomnavigators/settings.dart';
import '../components/profilescreen.dart';
import '../pages/homepages/programming.dart';
import '../pages/homepages/questions.dart';
import '../pages/homepages/quiz.dart';
import '../pages/homepages/recommendation.dart';
import '../pages/homepages/simplified.dart';
import '../pages/homepages/track.dart';

class Interface extends StatefulWidget {
  const Interface({super.key});
   
   

  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const InterfaceHomePage(),
    const CoursesPage(),
    const ReminderPage(),
    const SettingsPage(),
  ];

  final List<String> _titles = [
    'Course Correct',
    'Courses',
    'Reminders',
    'Settings',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ignore: deprecated_member_use
    ModalRoute.of(context)?.addScopedWillPopCallback(() async {
      if (_selectedIndex == 0) {
        // If on the Home page, exit the app
        SystemNavigator.pop();
      } else {
        // If not on the Home page, navigate back to it
        setState(() {
          _selectedIndex = 0;
        });
      }
      return false;
    });
  }

  @override
  void dispose() {
    // ignore: deprecated_member_use
    ModalRoute.of(context)?.removeScopedWillPopCallback(() async => false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.1), // Shadow color and transparency
                offset:
                    const Offset(0, 2), // Horizontal and vertical shadow offset
                blurRadius: 6.0, // Softness of the shadow
              ),
            ],
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              _titles[_selectedIndex],
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Times New Roman',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ), // Background set to transparent
            elevation: 0, // Disable default AppBar shadow
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "Profile") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                        value: "Profile", child: Text("Profile")),
                    const PopupMenuItem(
                        value: "Logout", child: Text("Logout")),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Reminder'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class InterfaceHomePage extends StatelessWidget {
  const InterfaceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          MenuButton(
            icon: Icons.question_answer,
            label: 'Questions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuestionsScreen()),
              );
            },
          ),
          MenuButton(
            icon: Icons.quiz,
            label: 'Quiz',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage()),
              );
            },
          ),
          MenuButton(
            icon: Icons.recommend,
            label: 'Recommendations',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Recommendation()),
              );
            },
          ),
          MenuButton(
            icon: Icons.show_chart,
            label: 'Track academic progress',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackPage()),
              );
            },
          ),
          MenuButton(
            icon: Icons.book,
            label: 'Simplified study materials',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SimplifiedPage()),
              );
            },
          ),
          MenuButton(
            icon: Icons.code,
            label: 'Programming languages',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProgrammingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

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
          leading: Icon(icon, color: Colors.white),
          title: Text(label, style: const TextStyle(color: Colors.white)),
          onTap: onTap,
        ),
      ),
    );
  }
}
