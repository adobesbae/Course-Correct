import 'package:course_correct/screens/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import '../profileprovider.dart'; // Adjust the import path if necessary

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure you are correctly listening to profile provider for updates
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Interface()),
            );
          },
          child: const Icon(Icons.arrow_back_ios, size: 15),
        ),
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Profile Image with tap to view full screen
              GestureDetector(
                onTap: () {
                  if (profileProvider.profileImageBytes != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                          imageBytes: profileProvider.profileImageBytes!,
                        ),
                      ),
                    );
                  }
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: profileProvider.profileImageBytes != null
                      ? MemoryImage(profileProvider.profileImageBytes!)
                      : null,
                  child: profileProvider.profileImageBytes == null
                      ? const Icon(Icons.person, size: 60, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 20),

              // Name
              buildProfileDetail(
                label: 'Name',
                value: profileProvider.name.isNotEmpty
                    ? profileProvider.name
                    : 'Not Set',
              ),
              const SizedBox(height: 20),

              // School
              buildProfileDetail(
                label: 'School',
                value: profileProvider.school.isNotEmpty
                    ? profileProvider.school
                    : 'Not Set',
              ),
              const SizedBox(height: 20),

              // Level
              buildProfileDetail(
                label: 'Level',
                value: profileProvider.level.isNotEmpty
                    ? profileProvider.level
                    : 'Not Set',
              ),
              const SizedBox(height: 20),

              // About
              buildProfileDetail(
                label: 'About',
                value: profileProvider.about.isNotEmpty
                    ? profileProvider.about
                    : 'Not Set',
              ),
              const SizedBox(height: 30),

              // Edit Profile Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile-settings');
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to Display Profile Detail, Center-Aligned
  Widget buildProfileDetail({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Full Screen Image Viewer
class FullScreenImage extends StatelessWidget {
  final Uint8List imageBytes;

  const FullScreenImage({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.memory(imageBytes),
      ),
    );
  }
}
