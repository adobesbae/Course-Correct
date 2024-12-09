import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios,
          size: 15,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Help and Support',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Course Correct',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const Text(
              'Beta Version',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "We'd like to know your thoughts about this app",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Contact us',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {},
              child: const Text(
                'Rate the app',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: const Text(
                'Terms and Privacy Policy',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Divider(color: Colors.grey),

            // Footer
            const Spacer(),
            Center(
              child: Text(
                '2024 © Course Correct',
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Help',
        child: Icon(Icons.help),
      ),
    );
  }
}
