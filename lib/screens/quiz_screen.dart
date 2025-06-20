import 'package:flutter/material.dart';
import '../data/questions.dart';
import '../sound/sound_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';

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
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    questions = questionsBySubject[widget.subject] ?? [];
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void checkAnswer(String selected) {
    if (selected == questions[currentQuestion]['answer']) {
      score++;
    }

    SoundManager.playClickSound();

    setState(() {
      currentQuestion++;
      if (currentQuestion >= questions.length) {
        SoundManager.playCongratsSound();
        _confettiController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion >= questions.length) {
      return Scaffold(
        backgroundColor: const Color(0xFFE6F4F1),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_rounded, size: 100, color: Colors.amber),
                  const SizedBox(height: 20),
                  Text(
                    'Your score: $score/${questions.length}',
                    style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Back to subjects', style: GoogleFonts.poppins(fontSize: 18)),
                  ),
                ],
              ),
            ),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 40,
              colors: const [Colors.teal, Colors.orange, Colors.pink, Colors.yellow],
            ),
          ],
        ),
      );
    }

    var q = questions[currentQuestion];

    return Scaffold(
      backgroundColor: const Color(0xFFE6F4F1),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.subject, style: GoogleFonts.poppins()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              backgroundColor: Colors.teal[100],
              color: Colors.teal,
              minHeight: 10,
            ),
            const SizedBox(height: 20),

            // Question Card with Fade Animation
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey(q['question']),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  q['question'] as String,
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Options
            ...(q['options'] as List<String>).map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.teal, width: 2),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () => checkAnswer(option),
                  child: Text(
                    option,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
