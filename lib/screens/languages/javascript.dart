import 'package:flutter/material.dart';

class JavaScript extends StatefulWidget {
  const JavaScript({super.key});

  @override
  JavaScriptState createState() => JavaScriptState();
}

class JavaScriptState extends State<JavaScript> {
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
      questionText: "What is JavaScript primarily used for?",
      options: [
        Option(text: "Mobile app development", isCorrect: false),
        Option(text: "Web development", isCorrect: true),
        Option(text: "Game development", isCorrect: false),
        Option(text: "Machine learning", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which company developed JavaScript?",
      options: [
        Option(text: "Microsoft", isCorrect: false),
        Option(text: "Google", isCorrect: false),
        Option(text: "Netscape", isCorrect: true),
        Option(text: "Apple", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What does '=== ' operator mean in JavaScript?",
      options: [
        Option(text: "Equality", isCorrect: false),
        Option(text: "Strict equality", isCorrect: true),
        Option(text: "Assignment", isCorrect: false),
        Option(text: "Comparison", isCorrect: false),
      ],
    ),
    // Add more JavaScript-related questions here
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
          "JavaScript",
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
                        fontSize: 18, fontWeight: FontWeight.bold),
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
      home: JavaScript(),
    ));
