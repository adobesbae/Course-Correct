import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  ReminderPageState createState() => ReminderPageState();
}

class ReminderPageState extends State<ReminderPage> {
  List<Reminder> reminders = [];

  @override
  void initState() {
    super.initState();
    NotificationService.initializeNotifications();
    _loadReminders(); // Load reminders from SharedPreferences
  }

  // Load reminders from SharedPreferences
  _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? remindersJson = prefs.getString('reminders');
    if (remindersJson != null) {
      final List<dynamic> decodedList = jsonDecode(remindersJson);
      setState(() {
        reminders = decodedList
            .map((json) => Reminder.fromJson(json))
            .toList(); // Convert JSON back to Reminder objects
      });
    }
  }

  // Save reminders to SharedPreferences
  _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> remindersJson =
        reminders.map((reminder) => reminder.toJson()).toList();
    prefs.setString('reminders', jsonEncode(remindersJson));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: reminders.isEmpty
          ? const Center(child: Text('No reminders yet.'))
          : ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return Card(
                  child: ListTile(
                    title: Text(reminder.title),
                    subtitle: Text(
                      '${reminder.courseCode} - ${DateFormat('MMM d, h:mm a').format(reminder.dateTime)}',
                    ),
                    trailing: Icon(
                      reminder.isCompleted ? Icons.check_circle : Icons.alarm,
                      color:
                          reminder.isCompleted ? Colors.green : Colors.orange,
                    ),
                    onTap: () {
                      setState(() {
                        reminder.isCompleted = !reminder.isCompleted;
                      });
                      _saveReminders(); // Save the updated list
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newReminder = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddReminderScreen()),
          );
          if (newReminder != null && mounted) {
            setState(() {
              reminders.add(newReminder);
            });
            _saveReminders(); // Save the new list
            NotificationService.scheduleReminderNotification(newReminder);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  AddReminderScreenState createState() => AddReminderScreenState();
}

class AddReminderScreenState extends State<AddReminderScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _courseController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

void _pickDateTime() async {
  // Ensure the widget is still mounted before proceeding
  if (!mounted) return;

  // Show date picker
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  // Check if date was selected and widget is still mounted
  if (date != null && mounted) {
    // Show time picker
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    // Check if time was selected and widget is still mounted
    if (time != null && mounted) {
      setState(() {
        _selectedDate = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, size: 15),
          ),
          title: const Text(
            'Add Reminder',
            style: TextStyle(
              fontSize: 18,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _courseController,
              decoration: const InputDecoration(labelText: 'Course Code'),
            ),
            const SizedBox(height: 20),
            Text(
                'Selected Date: ${DateFormat('MMM d, h:mm a').format(_selectedDate)}'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickDateTime,
              child: const Text('Pick Date & Time'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                final newReminder = Reminder(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dateTime: _selectedDate,
                  courseCode: _courseController.text,
                  priority: 'Medium',
                  tags: [],
                );
                Navigator.pop(context, newReminder);
              },
              child: const Text('Save Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}

class Reminder {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String courseCode;
  final String priority;
  final List<String> tags;
  bool isCompleted;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.courseCode,
    required this.priority,
    required this.tags,
    this.isCompleted = false,
  });

  // Convert Reminder to JSON (for saving to SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'courseCode': courseCode,
      'priority': priority,
      'tags': tags,
      'isCompleted': isCompleted,
    };
  }

  // Convert JSON back to Reminder (for loading from SharedPreferences)
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      courseCode: json['courseCode'],
      priority: json['priority'],
      tags: List<String>.from(json['tags']),
      isCompleted: json['isCompleted'],
    );
  }
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    try {
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings settings =
          InitializationSettings(android: androidSettings);

      // Initialize the notifications plugin
      await _notificationsPlugin.initialize(settings);
    } catch (e) {
      debugPrint("Error initializing notifications: $e");
    }
  }

  static Future<void> scheduleReminderNotification(Reminder reminder) async {
    try {
      tzdata.initializeTimeZones();
    } catch (e) {
      debugPrint("Error initializing timezone: $e");
      return;
    }

    try {
      final scheduledDate = tz.TZDateTime.from(reminder.dateTime, tz.local);

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'reminder_channel',
        'Reminders',
        channelDescription: 'Course Correct Reminder Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails platformDetails =
          NotificationDetails(android: androidDetails);

      await _notificationsPlugin.zonedSchedule(
        reminder.id.hashCode,
        reminder.title,
        'Course: ${reminder.courseCode}',
        scheduledDate,
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      debugPrint("Error scheduling notification: $e");
    }
  }
}
