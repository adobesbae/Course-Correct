import 'package:flutter/material.dart';

class Swift extends StatefulWidget {
  const Swift({super.key});

  @override
  SwiftState createState() => SwiftState();
}

class SwiftState extends State<Swift> {
  final List<Question> _originalQuestions = [
    Question(
      questionText: "What is Swift primarily used for?",
      options: [
        Option(text: "Mobile app development", isCorrect: true),
        Option(text: "Web development", isCorrect: false),
        Option(text: "Game development", isCorrect: false),
        Option(text: "Machine learning", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Swift was introduced by which company?",
      options: [
        Option(text: "Google", isCorrect: false),
        Option(text: "Apple", isCorrect: true),
        Option(text: "Microsoft", isCorrect: false),
        Option(text: "IBM", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What file extension is used for Swift files?",
      options: [
        Option(text: ".swift", isCorrect: true),
        Option(text: ".java", isCorrect: false),
        Option(text: ".js", isCorrect: false),
        Option(text: ".py", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is a key feature of Swift?",
      options: [
        Option(text: "Garbage collection", isCorrect: false),
        Option(text: "Safety and speed", isCorrect: true),
        Option(text: "Dynamic typing", isCorrect: false),
        Option(text: "Lack of libraries", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Swift supports which type of programming?",
      options: [
        Option(text: "Object-oriented", isCorrect: true),
        Option(text: "Functional", isCorrect: true),
        Option(text: "Procedural", isCorrect: true),
        Option(text: "All of the above", isCorrect: true),
      ],
    ),
    Question(
      questionText: "What is the keyword to declare constants in Swift?",
      options: [
        Option(text: "let", isCorrect: true),
        Option(text: "const", isCorrect: false),
        Option(text: "final", isCorrect: false),
        Option(text: "var", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which collection type is used to store unique values in Swift?",
      options: [
        Option(text: "Array", isCorrect: false),
        Option(text: "Set", isCorrect: true),
        Option(text: "Dictionary", isCorrect: false),
        Option(text: "List", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is the default access level for Swift entities?",
      options: [
        Option(text: "Private", isCorrect: false),
        Option(text: "Internal", isCorrect: true),
        Option(text: "Public", isCorrect: false),
        Option(text: "Protected", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is SwiftUI?",
      options: [
        Option(text: "A UI framework for building iOS apps", isCorrect: true),
        Option(text: "A backend library", isCorrect: false),
        Option(text: "An IDE", isCorrect: false),
        Option(text: "A testing tool", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What does '?' signify in Swift?",
      options: [
        Option(text: "Optional", isCorrect: true),
        Option(text: "Null", isCorrect: false),
        Option(text: "Default value", isCorrect: false),
        Option(text: "Pointer", isCorrect: false),
      ],
    ),
  ];

  late List<Question> _questions;
  final Map<int, int> _selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    _shuffleQuestions();
  }

  void _shuffleQuestions() {
    _questions = List.from(_originalQuestions)..shuffle();
  }

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
                _shuffleQuestions();
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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 15),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Swift",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed:
                _selectedAnswers.length == _questions.length ? _submitQuiz : null,
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
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(question.options.length, (optionIndex) {
                    final option = question.options[optionIndex];

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
                      selected: _selectedAnswers[index] == optionIndex,
                    );
                  }),
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
      home: Swift(),
    ));
