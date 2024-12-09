import 'package:flutter/material.dart';

class Java extends StatefulWidget {
  const Java({super.key});

  @override
  JavaState createState() => JavaState();
}

class JavaState extends State<Java> {
  late List<Question> _questions;
  final Map<int, int> _selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    _questions = List.from(_originalQuestions)..shuffle();
  }

  final List<Question> _originalQuestions = [
    Question(
      questionText: "What is Java primarily used for?",
      options: [
        Option(text: "Mobile app development", isCorrect: true),
        Option(text: "Web development", isCorrect: false),
        Option(text: "Game development", isCorrect: false),
        Option(text: "Machine learning", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which company originally developed Java?",
      options: [
        Option(text: "Microsoft", isCorrect: false),
        Option(text: "Google", isCorrect: false),
        Option(text: "Sun Microsystems", isCorrect: true),
        Option(text: "Apple", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is the file extension for Java source files?",
      options: [
        Option(text: ".java", isCorrect: true),
        Option(text: ".class", isCorrect: false),
        Option(text: ".js", isCorrect: false),
        Option(text: ".py", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What does the JVM stand for?",
      options: [
        Option(text: "Java Virtual Machine", isCorrect: true),
        Option(text: "Java Version Manager", isCorrect: false),
        Option(text: "Java Video Maker", isCorrect: false),
        Option(text: "Java Value Monitor", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which keyword is used to define a class in Java?",
      options: [
        Option(text: "function", isCorrect: false),
        Option(text: "define", isCorrect: false),
        Option(text: "class", isCorrect: true),
        Option(text: "create", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which method is the entry point for any Java program?",
      options: [
        Option(text: "main()", isCorrect: true),
        Option(text: "start()", isCorrect: false),
        Option(text: "init()", isCorrect: false),
        Option(text: "run()", isCorrect: false),
      ],
    ),
    Question(
      questionText:
          "Which data type is used to store a single character in Java?",
      options: [
        Option(text: "String", isCorrect: false),
        Option(text: "char", isCorrect: true),
        Option(text: "int", isCorrect: false),
        Option(text: "boolean", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which package is automatically imported in Java?",
      options: [
        Option(text: "java.util", isCorrect: false),
        Option(text: "java.io", isCorrect: false),
        Option(text: "java.lang", isCorrect: true),
        Option(text: "java.net", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which loop is guaranteed to execute at least once?",
      options: [
        Option(text: "for", isCorrect: false),
        Option(text: "while", isCorrect: false),
        Option(text: "do-while", isCorrect: true),
        Option(text: "none of the above", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which operator is used to compare two values in Java?",
      options: [
        Option(text: "=", isCorrect: false),
        Option(text: "==", isCorrect: true),
        Option(text: "!=", isCorrect: false),
        Option(text: "<>", isCorrect: false),
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
          "Java",
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
      home: Java(),
    ));
