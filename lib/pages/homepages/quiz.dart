import 'dart:async';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  final int _quizDuration = 1200; // 20 minutes in seconds
  late int _remainingTime = _quizDuration;
  late Timer _timer;

  int currentScore = 0;

  final List<Map<String, dynamic>> questions = [
    // Java Questions
    {'question': 'What is the default value of a boolean in Java?', 'options': ['true', 'false', 'null', '0'], 'answer': 'false'},
    {'question': 'Which keyword is used to inherit a class in Java?', 'options': ['inherit', 'extends', 'implements', 'override'], 'answer': 'extends'},
    {'question': 'Java is platform-independent because of?', 'options': ['JVM', 'Compiler', 'Bytecode', 'All of the above'], 'answer': 'JVM'},
    {'question': 'Which method is the entry point for a Java program?', 'options': ['start()', 'main()', 'run()', 'entry()'], 'answer': 'main()'},
    {'question': 'Java is a ___-oriented programming language.', 'options': ['Procedure', 'Object', 'Aspect', 'Functional'], 'answer': 'Object'},
    {'question': 'Which of these is not a Java keyword?', 'options': ['class', 'import', 'goto', 'function'], 'answer': 'function'},
    {'question': 'Which data type is used to create a variable that should store text?', 'options': ['String', 'Text', 'Char', 'string'], 'answer': 'String'},
    {'question': 'Which keyword is used to declare a constant in Java?', 'options': ['const', 'final', 'static', 'constant'], 'answer': 'final'},
    {'question': 'What is the size of an int in Java?', 'options': ['2 bytes', '4 bytes', '8 bytes', '16 bytes'], 'answer': '4 bytes'},
    {'question': 'What is the process of converting a primitive type into an object in Java?', 'options': ['Casting', 'Boxing', 'Wrapping', 'Autoboxing'], 'answer': 'Autoboxing'},
    
    // Python Questions
    {'question': 'What is the output of len("Python")?', 'options': ['5', '6', '7', 'None'], 'answer': '6'},
    {'question': 'How are comments denoted in Python?', 'options': ['//', '#', '/* */', '--'], 'answer': '#'},
    {'question': 'Which function is used to output content in Python?', 'options': ['write()', 'print()', 'console()', 'show()'], 'answer': 'print()'},
    {'question': 'What is the default value of a Python variable?', 'options': ['null', 'undefined', 'None', 'False'], 'answer': 'None'},
    {'question': 'Which data type is immutable in Python?', 'options': ['List', 'Tuple', 'Dictionary', 'Set'], 'answer': 'Tuple'},
    {'question': 'How do you declare a function in Python?', 'options': ['function', 'def', 'func', 'lambda'], 'answer': 'def'},
    {'question': 'What is the output of 2 ** 3 in Python?', 'options': ['6', '8', '9', 'Error'], 'answer': '8'},
    {'question': 'How do you create a dictionary in Python?', 'options': ['()', '[]', '{}', '<>'], 'answer': '{}'},
    {'question': 'What is Python primarily used for?', 'options': ['Web', 'Data Science', 'Machine Learning', 'All'], 'answer': 'All'},
    {'question': 'Which of these is not a Python framework?', 'options': ['Flask', 'Django', 'Spring', 'FastAPI'], 'answer': 'Spring'},
    
    // Dart Questions
    {'question': 'What is Dart primarily used for?', 'options': ['Web', 'Mobile', 'Both', 'None'], 'answer': 'Both'},
    {'question': 'Which keyword declares a constant in Dart?', 'options': ['const', 'final', 'var', 'let'], 'answer': 'const'},
    {'question': 'What is a nullable variable in Dart?', 'options': ['int?', 'bool?', 'Any type with ?', 'All of the above'], 'answer': 'All of the above'},
    {'question': 'What function is the entry point in a Dart program?', 'options': ['main()', 'start()', 'init()', 'run()'], 'answer': 'main()'},
    {'question': 'Dart is developed by which company?', 'options': ['Microsoft', 'Apple', 'Google', 'Facebook'], 'answer': 'Google'},
    {'question': 'Which symbol is used for string interpolation in Dart?', 'options': ['#', '\$', '&', '%'], 'answer': '\$'},
    {'question': 'Dart supports which types of programming?', 'options': ['Functional', 'Object-Oriented', 'Both', 'None'], 'answer': 'Both'},
    {'question': 'Which Dart collection is ordered?', 'options': ['List', 'Map', 'Set', 'Dictionary'], 'answer': 'List'},
    {'question': 'What is the default value of a nullable variable in Dart?', 'options': ['null', 'undefined', 'error', 'empty'], 'answer': 'null'},
    {'question': 'Dart code is compiled into?', 'options': ['JavaScript', 'Assembly', 'Machine Code', 'None'], 'answer': 'JavaScript'},
    
    // JavaScript Questions
    {'question': 'What is JavaScript primarily used for?', 'options': ['Front-End', 'Back-End', 'Both', 'None'], 'answer': 'Both'},
    {'question': 'Which keyword declares a variable in ES6?', 'options': ['var', 'let', 'const', 'Both let and const'], 'answer': 'Both let and const'},
    {'question': 'Which method is used to parse JSON in JavaScript?', 'options': ['JSON.parse()', 'parse()', 'JSON.stringify()', 'stringify()'], 'answer': 'JSON.parse()'},
    {'question': 'What is the default value of an uninitialized variable in JavaScript?', 'options': ['undefined', 'null', 'error', 'empty'], 'answer': 'undefined'},
    {'question': 'What is the output of typeof NaN in JavaScript?', 'options': ['number', 'NaN', 'undefined', 'null'], 'answer': 'number'},
    {'question': 'Which symbol is used for single-line comments in JavaScript?', 'options': ['//', '#', '/* */', '<!'], 'answer': '//'},
    {'question': 'Which function is used to delay code execution in JavaScript?', 'options': ['setTimeout()', 'delay()', 'wait()', 'setInterval()'], 'answer': 'setTimeout()'},
    {'question': 'What is the output of 0 == false in JavaScript?', 'options': ['true', 'false', 'error', 'undefined'], 'answer': 'true'},
    {'question': 'JavaScript is a ___-typed language.', 'options': ['strongly', 'weakly', 'dynamically', 'statically'], 'answer': 'dynamically'},
    {'question': 'Which JavaScript framework is used for building UI?', 'options': ['Angular', 'React', 'Vue', 'All of the above'], 'answer': 'All of the above'},
    
    // Swift Questions
    {'question': 'What is Swift primarily used for?', 'options': ['iOS Development', 'Web Development', 'Game Development', 'All'], 'answer': 'iOS Development'},
    {'question': 'Which keyword is used to declare a constant in Swift?', 'options': ['const', 'let', 'var', 'final'], 'answer': 'let'},
    {'question': 'How do you create a function in Swift?', 'options': ['func', 'function', 'def', 'create'], 'answer': 'func'},
    {'question': 'What is the output of "1 + 1.0" in Swift?', 'options': ['2', '2.0', 'error', 'undefined'], 'answer': '2.0'},
    {'question': 'What is a tuple in Swift?', 'options': ['Array', 'Dictionary', 'Collection of values', 'Set'], 'answer': 'Collection of values'},
    {'question': 'Swift is ___-typed.', 'options': ['dynamically', 'strongly', 'weakly', 'loosely'], 'answer': 'strongly'},
    {'question': 'What is the default value of an optional in Swift?', 'options': ['nil', 'undefined', 'null', 'empty'], 'answer': 'nil'},
    {'question': 'Which Swift statement is used for error handling?', 'options': ['try-catch', 'throw', 'do-catch', 'handle'], 'answer': 'do-catch'},
    {'question': 'Swift is developed by?', 'options': ['Google', 'Apple', 'Microsoft', 'Facebook'], 'answer': 'Apple'},
    {'question': 'What is the output of type(of: 42) in Swift?', 'options': ['Int', 'String', 'Float', 'Undefined'], 'answer': 'Int'},
  ];

  late List<Map<String, dynamic>> shuffledQuestions;
  late Map<int, String?> _selectedAnswers;

  @override
  void initState() {
    super.initState();
    shuffledQuestions = List.of(questions)..shuffle();
    _selectedAnswers = {};
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime <= 0) {
        _timer.cancel();
        _submitQuiz();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void _submitQuiz() {
    _timer.cancel();
    int score = 0;
    for (int i = 0; i < shuffledQuestions.length; i++) {
      if (_selectedAnswers[i] == shuffledQuestions[i]['answer']) {
        score++;
      }
    }
    _showScore(score);
  }

  void _showScore(int score) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed'),
        content: Text('Your score is $score/${shuffledQuestions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 8.0)
            ]
          ),
          child: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios, size: 15),
            ),
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quiz',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  '${(_remainingTime ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: shuffledQuestions.length,
        itemBuilder: (context, index) {
          final question = shuffledQuestions[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1}. ${question['question']}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ...question['options'].map<Widget>((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: _selectedAnswers[index],
                      onChanged: (value) {
                        setState(() {
                          _selectedAnswers[index] = value;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitQuiz,
        label: const Text('Submit'),
        icon: const Icon(Icons.done),
      ),
    );
  }
}