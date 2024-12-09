import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../profileprovider.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  Uint8List? _profileImageBytes;
  final picker = ImagePicker();

  // Text Controllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    nameController.text = profileProvider.name;
    schoolController.text = profileProvider.school;
    levelController.text = profileProvider.level;
    aboutController.text = profileProvider.about;
    _profileImageBytes = profileProvider.profileImageBytes;
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _profileImageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
        ),
        title: const Text(
                  'Profile Settings',
                  style: TextStyle(fontSize: 18),
                ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: _profileImageBytes != null
                    ? MemoryImage(_profileImageBytes!)
                    : null,
                child: _profileImageBytes == null
                    ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // Name Input
            buildTextField(controller: nameController, label: 'Name'),
            const SizedBox(height: 16),

            // School Input
            buildTextField(controller: schoolController, label: 'School'),
            const SizedBox(height: 16),

            // Level Input
            buildTextField(controller: levelController, label: 'Level'),
            const SizedBox(height: 16),

            // About Input
            buildTextField(
                controller: aboutController, label: 'About', maxLines: 3),
            const SizedBox(height: 24),

            // Save Button
            ElevatedButton(
              onPressed: () {
                profileProvider.updateProfile(
                  name: nameController.text,
                  school: schoolController.text,
                  level: levelController.text,
                  about: aboutController.text,
                  profileImageBytes: _profileImageBytes,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile Saved Successfully!')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
