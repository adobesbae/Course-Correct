import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profileprovider.dart';
import '../pages/settingspages/profile.dart';
import '../pages/settingspages/calendar.dart';
import '../pages/settingspages/course.dart';
import '../pages/settingspages/helpandsupport.dart';
import '../pages/settingspages/notifications.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Function to show under development message with customizable text
  void showUnderDevelopmentDialog(
      BuildContext context, String featureName, String customMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$featureName  Under Development'),
          content: Text(customMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display Profile Section with Profile Image and Name
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileSettings()),
                  );
                },
                child: Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          // Profile Image
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: profileProvider.profileImageBytes != null
                                ? MemoryImage(profileProvider.profileImageBytes!)
                                : null,
                            child: profileProvider.profileImageBytes == null
                                ? const Icon(Icons.person, size: 30, color: Colors.grey)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          // Name and School
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileProvider.name.isNotEmpty
                                    ? profileProvider.name
                                    : 'Not Set',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                profileProvider.school.isNotEmpty
                                    ? profileProvider.school
                                    : 'School: Not Set',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Other Settings Options
              MenuButton(
                icon: Icons.bookmark_add_outlined,
                label: 'Course Preferences',
                iconColor: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoursePreferencesScreen()),
                  );
                },
              ),
              MenuButton(
                icon: Icons.calendar_today,
                label: 'Calendar Integration',
                iconColor: Colors.yellow,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calendar()),
                  );
                },
              ),
              NotificationMenuButton(
                icon: Icons.notifications,
                label: 'Notifications',
                iconColor: Colors.orange,
              ),
              MenuButton(
                icon: Icons.brightness_4,
                label: 'Theme',
                iconColor: Colors.red,
                onTap: () {
                  showUnderDevelopmentDialog(
                    context,
                    '',
                    'Theming options are coming soon. Stay tuned for updates!',
                  );
                },
              ),
              MenuButton(
                icon: Icons.language,
                label: 'Language',
                iconColor: Colors.blue,
                onTap: () {
                  showUnderDevelopmentDialog(
                    context,
                    '',
                    'Language settings are under development. We are working on adding more languages!',
                  );
                },
              ),
              MenuButton(
                icon: Icons.quiz,
                label: 'Quizzers Settings',
                iconColor: Colors.green,
                onTap: () {
                  showUnderDevelopmentDialog(
                    context,
                    '',
                    'Quiz feature is under development. Get ready for interactive quizzes!',
                  );
                },
              ),
              MenuButton(
                icon: Icons.lock,
                label: 'Privacy and Security',
                iconColor: Colors.yellow,
                onTap: () {
                  showUnderDevelopmentDialog(
                    context,
                    '',
                    'We are enhancing privacy settings to protect your data better.',
                  );
                },
              ),
              MenuButton(
                icon: Icons.help,
                label: 'Help and Support',
                iconColor: Colors.orange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpAndSupport()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable MenuButton class
class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(label, style: const TextStyle(color: Colors.black87)),
          onTap: onTap,
        ),
      ),
    );
  }
}
