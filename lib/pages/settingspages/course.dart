import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class CoursePreferencesScreen extends StatefulWidget {
  const CoursePreferencesScreen({super.key});

  @override
  CoursePreferencesScreenState createState() => CoursePreferencesScreenState();
}

class CoursePreferencesScreenState extends State<CoursePreferencesScreen> {
  final formKey = GlobalKey<FormState>();

  // Form fields
  TextEditingController studyTimeController = TextEditingController();
  String coursePriority = 'High';
  String learningStyle = 'Visual';
  bool receiveNotifications = true;
  bool preferStudyGroups = false;
  String examPreparation = 'Practice Tests';

  // Notification setup
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _initializeNotifications();
    tz.initializeTimeZones(); // Initialize timezone data
  }

  // Initialize the notification plugin
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request permission for Android 13+ using permission_handler
    if (await Permission.notification.isDenied ||
        await Permission.notification.isPermanentlyDenied) {
      await Permission.notification.request();
    }
  }

  // Load preferences from SharedPreferences
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      studyTimeController.text = prefs.getString('studyTime') ?? '';
      coursePriority = prefs.getString('coursePriority') ?? 'High';
      learningStyle = prefs.getString('learningStyle') ?? 'Visual';
      receiveNotifications = prefs.getBool('receiveNotifications') ?? true;
      preferStudyGroups = prefs.getBool('preferStudyGroups') ?? false;
      examPreparation = prefs.getString('examPreparation') ?? 'Practice Tests';
    });
  }

  // Schedule a notification
  Future<void> _scheduleNotification() async {
    var scheduledNotificationDateTime =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'course_correct_channel',
      'Course Correct Notifications',
      channelDescription: 'Notifications for Course Correct app reminders',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder',
      'It\'s time for your study session!',
      scheduledNotificationDateTime,
      platformDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // Save preferences to SharedPreferences
  _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('studyTime', studyTimeController.text);
    prefs.setString('coursePriority', coursePriority);
    prefs.setString('learningStyle', learningStyle);
    prefs.setBool('receiveNotifications', receiveNotifications);
    prefs.setBool('preferStudyGroups', preferStudyGroups);
    prefs.setString('examPreparation', examPreparation);

    if (receiveNotifications) {
      _scheduleNotification();
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences Saved!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back_ios, size: 15, color: Colors.black),
        ),
        title: Text(
          'Course Preferences',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              // Study Time
              TextFormField(
                controller: studyTimeController,
                decoration: const InputDecoration(
                  labelText: 'Preferred Study Time',
                  hintText: 'e.g., 8 AM - 12 PM',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your preferred study time.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Notification Preference
              SwitchListTile(
                title: const Text('Receive Notifications'),
                value: receiveNotifications,
                onChanged: (bool value) {
                  setState(() {
                    receiveNotifications = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    _savePreferences();
                  }
                },
                child: const Text('Save Preferences'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
