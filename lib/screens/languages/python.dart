import 'package:flutter/material.dart';

class Python extends StatefulWidget {
  const Python({super.key});

  @override
  PythState createState() => PythState();
}

class PythState extends State<Python> {
  final List<Question> _originalQuestions = [
    Question(
      questionText: "What is Python primarily used for?",
      options: [
        Option(text: "Mobile app development", isCorrect: false),
        Option(text: "Web development", isCorrect: true),
        Option(text: "Game development", isCorrect: false),
        Option(text: "Machine learning", isCorrect: true),
      ],
    ),
    Question(
      questionText: "What is the file extension for Python files?",
      options: [
        Option(text: ".py", isCorrect: true),
        Option(text: ".java", isCorrect: false),
        Option(text: ".php", isCorrect: false),
        Option(text: ".js", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What keyword is used to define a function in Python?",
      options: [
        Option(text: "func", isCorrect: false),
        Option(text: "def", isCorrect: true),
        Option(text: "function", isCorrect: false),
        Option(text: "lambda", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which of the following is a Python data type?",
      options: [
        Option(text: "string", isCorrect: true),
        Option(text: "text", isCorrect: false),
        Option(text: "character", isCorrect: false),
        Option(text: "number", isCorrect: false),
      ],
    ),
    Question(
      questionText: "How do you start a comment in Python?",
      options: [
        Option(text: "//", isCorrect: false),
        Option(text: "#", isCorrect: true),
        Option(text: "/*", isCorrect: false),
        Option(text: "<!--", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which library is used for data analysis in Python?",
      options: [
        Option(text: "NumPy", isCorrect: false),
        Option(text: "pandas", isCorrect: true),
        Option(text: "Matplotlib", isCorrect: false),
        Option(text: "Tkinter", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is the output of 'print(type([]))' in Python?",
      options: [
        Option(text: "<class 'tuple'>", isCorrect: false),
        Option(text: "<class 'list'>", isCorrect: true),
        Option(text: "<class 'dict'>", isCorrect: false),
        Option(text: "<class 'set'>", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What does 'len()' function do in Python?",
      options: [
        Option(text: "Returns the number of elements", isCorrect: true),
        Option(text: "Returns the last element", isCorrect: false),
        Option(text: "Returns the index of an element", isCorrect: false),
        Option(text: "Removes an element", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is the Python output of 2 ** 3?",
      options: [
        Option(text: "6", isCorrect: false),
        Option(text: "8", isCorrect: true),
        Option(text: "9", isCorrect: false),
        Option(text: "None", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which statement is used to handle exceptions in Python?",
      options: [
        Option(text: "catch", isCorrect: false),
        Option(text: "try-except", isCorrect: true),
        Option(text: "error", isCorrect: false),
        Option(text: "catch-finally", isCorrect: false),
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
          "Python",
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
      home: Python(),
    ));
