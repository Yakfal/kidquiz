import 'package:flutter/material.dart';
import '../data/questions.dart';
import '../sound/sound_manager.dart';
class QuizScreen extends StatefulWidget {
  final String subject;

   const QuizScreen({super.key, required this.subject});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Map<String, Object>> questions;
  int currentQuestion = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    questions = questionsBySubject[widget.subject] ?? [];
  }

  void checkAnswer(String selected) {
    if (selected == questions[currentQuestion]['answer']) {
      score++;
    }
    setState(() {
      currentQuestion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion >= questions.length) {
      SoundManager.playCongratsSound();
      return Scaffold(
        appBar: AppBar(title: Text(widget.subject)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your score: $score/${questions.length}', style: TextStyle(fontSize: 28)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => {
                  SoundManager.playClickSound(),
                  Navigator.pop(context),
                },
                child: Text('Back to subjects'),
              ),
            ],
          ),
        ),
      );
    }

    var q = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(title: Text(widget.subject)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(q['question'] as String, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ...(q['options'] as List<String>).map((option) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton(
                onPressed: () =>{
                  SoundManager.playClickSound(),
                  checkAnswer(option),
                },
                child: Text(option, style: TextStyle(fontSize: 20)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
