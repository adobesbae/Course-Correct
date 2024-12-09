import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';

class ProfileProvider with ChangeNotifier {
  String _name = '';
  String _school = '';
  String _level = '';
  String _about = '';
  Uint8List? _profileImageBytes;

  // Getters
  String get name => _name;
  String get school => _school;
  String get level => _level;
  String get about => _about;
  Uint8List? get profileImageBytes => _profileImageBytes;

  // Load profile data from SharedPreferences
  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    _name = prefs.getString('name') ?? '';
    _school = prefs.getString('school') ?? '';
    _level = prefs.getString('level') ?? '';
    _about = prefs.getString('about') ?? '';

    // Load profile image bytes if available
    final imageString = prefs.getString('profileImage');
    if (imageString != null) {
      _profileImageBytes = base64Decode(imageString);
    }

    notifyListeners();
  }

  // Save profile data to SharedPreferences
  Future<void> saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', _name);
    await prefs.setString('school', _school);
    await prefs.setString('level', _level);
    await prefs.setString('about', _about);

    // Save profile image as base64 string
    if (_profileImageBytes != null) {
      final imageString = base64Encode(_profileImageBytes!);
      await prefs.setString('profileImage', imageString);
    }

    notifyListeners();
  }

  // Update profile information
  void updateProfile({
    required String name,
    required String school,
    required String level,
    required String about,
    Uint8List? profileImageBytes,
  }) {
    _name = name;
    _school = school;
    _level = level;
    _about = about;

    if (profileImageBytes != null) {
      _profileImageBytes = profileImageBytes;
    }

    saveProfileData();
    notifyListeners();
  }

  // Method to update only the profile image
  void setProfileImage(Uint8List? bytes) {
    _profileImageBytes = bytes;
    saveProfileData();
    notifyListeners();
  }
}
