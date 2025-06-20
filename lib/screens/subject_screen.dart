import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import '../sound/sound_manager.dart';

class SubjectScreen extends StatelessWidget {
  final List<String> subjects = ['Math', 'English'];

  SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Subject')),
      body: ListView(
        children: subjects.map((subject) => ListTile(
          title: Text(subject),
          onTap: () {
            SoundManager.playClickSound();
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => QuizScreen(subject: subject),
            ));
          },
        )).toList(),
      ),
    );
  }
}
