import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalAppState {
  static Duration totalTimeSpent = Duration.zero;
  static DateTime? sessionStartTime;
  static Timer? globalTimer;

  static int quizzesAttempted = 0; // Track quizzes attempted globally
  static int questionsAnswered = 0; // Track questions answered globally

  static void startTimer(Function updateUI) {
    if (globalTimer == null) {
      sessionStartTime = DateTime.now();
      globalTimer = Timer.periodic(const Duration(milliseconds: 10), (_) {
        updateUI();
      });
    }
  }

  static void stopTimer() {
    if (sessionStartTime != null) {
      totalTimeSpent += DateTime.now().difference(sessionStartTime!);
      globalTimer?.cancel();
      globalTimer = null;
    }
  }

  static Future<void> loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    quizzesAttempted = prefs.getInt('quizzesAttempted') ?? 0;
    questionsAnswered = prefs.getInt('questionsAnswered') ?? 0;
  }

  static Future<void> saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('quizzesAttempted', quizzesAttempted);
    prefs.setInt('questionsAnswered', questionsAnswered);
  }

  // Increment quizzes attempted manually and save progress
  static void incrementQuizzesAttempted() {
    quizzesAttempted++;
    saveProgress(); // Save progress after increment
  }

  // Increment questions answered manually and save progress
  static void incrementQuestionsAnswered() {
    questionsAnswered++;
    saveProgress(); // Save progress after increment
  }
}

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    GlobalAppState.loadProgress(); // Load saved progress
    GlobalAppState.startTimer(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    GlobalAppState.stopTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      GlobalAppState.stopTimer();
    } else if (state == AppLifecycleState.resumed) {
      GlobalAppState.startTimer(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final elapsed = GlobalAppState.totalTimeSpent +
        (GlobalAppState.sessionStartTime != null
            ? now.difference(GlobalAppState.sessionStartTime!)
            : Duration.zero);

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
              'Track Academic Progress',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progress Overview',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  title: 'Quizzes Attempted',
                  value: '${GlobalAppState.quizzesAttempted}',
                  icon: Icons.assignment,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  title: 'Questions Answered',
                  value: '${GlobalAppState.questionsAnswered}',
                  icon: Icons.help_outline,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  title: 'Total Time Spent',
                  value:
                      '${elapsed.inHours}:${(elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}',
                  icon: Icons.access_time,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                // Add new card for manual increment of quizzes and questions
                _buildManualIncrementCard(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 30, color: color),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // New card for manual increment of quizzes and questions
  Widget _buildManualIncrementCard() {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quizzes Attempted',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      GlobalAppState.incrementQuizzesAttempted(); // Increment quizzes attempted
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Increase'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Questions Answered',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      GlobalAppState.incrementQuestionsAnswered(); // Increment questions answered
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Increase'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
