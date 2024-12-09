import 'package:course_correct/screens/languages/flutter.dart';
import 'package:course_correct/screens/languages/java.dart';
import 'package:course_correct/screens/languages/javascript.dart';
import 'package:course_correct/screens/languages/php.dart';
import 'package:course_correct/screens/languages/python.dart';
import 'package:flutter/material.dart';
import '../../screens/languages/swift.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> topics = [
      {
        'title': 'Flutter',
        'description': 'Build beautiful native apps in record time.',
        'imagePath': 'assets/images/flutter.png',
      },
      {
        'title': 'JavaScript',
        'description': 'The programming language of the web.',
        'imagePath': 'assets/images/javascript.png',
      },
      {
        'title': 'Python',
        'description': 'A versatile language great for AI and data science.',
        'imagePath': 'assets/images/python.png',
      },
      {
        'title': 'PHP',
        'description': 'Widely used for server-side web development.',
        'imagePath': 'assets/images/php.png',
      },
      {
        'title': 'Java',
        'description': 'Popular for enterprise and Android applications.',
        'imagePath': 'assets/images/java.png',
      },
      {
        'title': 'Swift',
        'description': 'The language for iOS and macOS apps.',
        'imagePath': 'assets/images/swift.png',
      },
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
              'Questions',
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
      backgroundColor: Colors.grey.shade100,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return buildListTile(
            context,
            title: topic['title']!,
            description: topic['description']!,
            imagePath: topic['imagePath']!,
            onTap: () {
              handleNavigation(context, topic['title']!);
            },
          );
        },
      ),
    );
  }

  Widget buildListTile(
    BuildContext context, {
    required String title,
    required String description,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void handleNavigation(BuildContext context, String topic) {
    Widget destinationScreen;
    switch (topic) {
      case 'Flutter':
        destinationScreen = const Flutter();
        break;
      case 'JavaScript':
        destinationScreen = const JavaScript();
        break;
      case 'Python':
        destinationScreen = const Python();
        break;
      case 'PHP':
        destinationScreen = const PHP();
        break;
      case 'Java':
        destinationScreen = const Java();
        break;
      case 'Swift':
        destinationScreen = const Swift();
        break;
      default:
        destinationScreen = const Placeholder(); // Fallback screen
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationScreen),
    );
  }
}

@override
Widget build(BuildContext context) {
  return buildTopicScreen(context, 'Swift');
}

// Reusable topic screen builder
Widget buildTopicScreen(BuildContext context, String topic) {
  return Scaffold(
    appBar: AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios, size: 18),
      ),
      title: Text(topic),
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
    ),
    body: Center(
      child: Text(
        'Details for $topic',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    ),
  );
}
