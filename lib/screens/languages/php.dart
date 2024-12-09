import 'package:flutter/material.dart';

class PHP extends StatefulWidget {
  const PHP({super.key});

  @override
  PythState createState() => PythState();
}

class PythState extends State<PHP> {
  final List<Question> _originalQuestions = [
    Question(
      questionText: "What does PHP stand for?",
      options: [
        Option(text: "Personal Home Page", isCorrect: false),
        Option(text: "PHP: Hypertext Preprocessor", isCorrect: true),
        Option(text: "Private Home Page", isCorrect: false),
        Option(text: "Public Home Page", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which of the following is a PHP superglobal variable?",
      options: [
        Option(text: "\$_GLOBAL", isCorrect: false),
        Option(text: "\$_SUPER", isCorrect: false),
        Option(text: "\$_SESSION", isCorrect: true),
        Option(text: "\$_ENVIRONMENT", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which of the following is used to include a file in PHP?",
      options: [
        Option(text: "import", isCorrect: false),
        Option(text: "require", isCorrect: true),
        Option(text: "include_once", isCorrect: true),
        Option(text: "load", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which of the following is the correct way to start a PHP block?",
      options: [
        Option(text: "&lt;?php", isCorrect: true),
        Option(text: "&lt;?PHP", isCorrect: true),
        Option(text: "&lt;?ph", isCorrect: false),
        Option(text: "&lt;php?", isCorrect: false),
      ],
    ),
    Question(
      questionText: "How can you define a constant in PHP?",
      options: [
        Option(text: "const", isCorrect: true),
        Option(text: "define", isCorrect: true),
        Option(text: "constant", isCorrect: false),
        Option(text: "set", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which function is used to open a file in PHP?",
      options: [
        Option(text: "openFile()", isCorrect: false),
        Option(text: "fopen()", isCorrect: true),
        Option(text: "fileOpen()", isCorrect: false),
        Option(text: "open()", isCorrect: false),
      ],
    ),
    Question(
      questionText: "What is the default file extension for PHP files?",
      options: [
        Option(text: ".html", isCorrect: false),
        Option(text: ".php", isCorrect: true),
        Option(text: ".ph", isCorrect: false),
        Option(text: ".xml", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which of the following is the correct way to add comments in PHP?",
      options: [
        Option(text: "// for single line comments", isCorrect: true),
        Option(text: "/* for multi-line comments */", isCorrect: true),
        Option(text: "// for multi-line comments", isCorrect: false),
        Option(text: "# for single line comments", isCorrect: true),
      ],
    ),
    Question(
      questionText: "Which PHP function is used to check the existence of a variable?",
      options: [
        Option(text: "is_var()", isCorrect: false),
        Option(text: "isset()", isCorrect: true),
        Option(text: "exists()", isCorrect: false),
        Option(text: "var_exist()", isCorrect: false),
      ],
    ),
    Question(
      questionText: "Which PHP function is used to destroy a session?",
      options: [
        Option(text: "session_destroy()", isCorrect: true),
        Option(text: "session_delete()", isCorrect: false),
        Option(text: "destroy_session()", isCorrect: false),
        Option(text: "unset_session()", isCorrect: false),
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
          "PHP",
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

// Models for Question and Option
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
      home: PHP(),
    ));
