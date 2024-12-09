import 'package:flutter/material.dart';

class Flutter extends StatefulWidget {
  const Flutter({super.key});

  @override
  FlutterState createState() => FlutterState();
}

class FlutterState extends State<Flutter> {
  late List<Question> _questions;
  final Map<int, int> _selectedAnswers =
      {}; // Store selected option index per question

  @override
  void initState() {
    super.initState();
    _questions = List.from(_originalQuestions)..shuffle(); // Shuffle questions
  }

  final List<Question> _originalQuestions = [
    Question(
      questionText: "What is Flutter primarily used for?",
      options: [
        Option(text: "Web development", isCorrect: false),
        Option(text: "Mobile app development", isCorrect: true),
        Option(text: "Game development", isCorrect: false),
        Option(text: "Desktop software", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which language is used to develop Flutter apps?",
      options: [
        Option(text: "Java", isCorrect: false),
        Option(text: "Kotlin", isCorrect: false),
        Option(text: "Dart", isCorrect: true),
        Option(text: "Python", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which company developed Flutter?",
      options: [
        Option(text: "Facebook", isCorrect: false),
        Option(text: "Microsoft", isCorrect: false),
        Option(text: "Google", isCorrect: true),
        Option(text: "Apple", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is a widget in Flutter?",
      options: [
        Option(text: "A design tool", isCorrect: false),
        Option(text: "A component of the UI", isCorrect: true),
        Option(text: "A database", isCorrect: false),
        Option(text: "A backend service", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What does the `setState()` method do in Flutter?",
      options: [
        Option(text: "Deletes the widget", isCorrect: false),
        Option(text: "Updates the UI", isCorrect: true),
        Option(text: "Saves data to the database", isCorrect: false),
        Option(text: "Navigates to another screen", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is the purpose of the `pubspec.yaml` file?",
      options: [
        Option(text: "Configures routes", isCorrect: false),
        Option(text: "Specifies project dependencies", isCorrect: true),
        Option(text: "Defines themes", isCorrect: false),
        Option(text: "Stores widget definitions", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which widget is used for user input?",
      options: [
        Option(text: "Text", isCorrect: false),
        Option(text: "TextField", isCorrect: true),
        Option(text: "Row", isCorrect: false),
        Option(text: "Column", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is the default alignment of widgets in a `Column`?",
      options: [
        Option(text: "Center", isCorrect: false),
        Option(text: "Top", isCorrect: true),
        Option(text: "Bottom", isCorrect: false),
        Option(text: "Right", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which widget is used to show images?",
      options: [
        Option(text: "Image", isCorrect: true),
        Option(text: "Text", isCorrect: false),
        Option(text: "Container", isCorrect: false),
        Option(text: "AppBar", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which method is used to navigate between screens?",
      options: [
        Option(text: "Navigator.push()", isCorrect: true),
        Option(text: "Navigator.goTo()", isCorrect: false),
        Option(text: "Screen.navigate()", isCorrect: false),
        Option(text: "Push.route()", isCorrect: false),
      ],
    ),
  ];

  void _submitQuiz() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      final selectedIndex = _selectedAnswers[i];
      if (selectedIndex != null &&
          _questions[i].options[selectedIndex].isCorrect) {
        score++;
      }
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Quiz Completed!"),
        content: Text("Your score is $score out of ${_questions.length}."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _selectedAnswers.clear();
                _questions = List.from(_originalQuestions)..shuffle();
              });
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Flutter",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _selectedAnswers.length == _questions.length
                ? _submitQuiz
                : null,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          final question = _questions[index];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.questionText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(
                    question.options.length,
                    (optionIndex) {
                      final option = question.options[optionIndex];
                      final isSelected = _selectedAnswers[index] == optionIndex;

                      return ListTile(
                        title: Text(option.text),
                        leading: Radio<int>(
                          value: optionIndex,
                          groupValue: _selectedAnswers[index],
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswers[index] = value!;
                            });
                          },
                        ),
                        selected: isSelected,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<Option> options;

  Question({required this.questionText, required this.options});
}

class Option {
  final String text;
  final bool isCorrect;

  Option({required this.text, required this.isCorrect});
}

void main() => runApp(const MaterialApp(
      home: Flutter(),
    ));
