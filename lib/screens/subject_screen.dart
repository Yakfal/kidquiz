import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class SubjectScreen extends StatelessWidget {
  final List<String> subjects = ['Math', 'English'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Subject')),
      body: ListView(
        children: subjects.map((subject) => ListTile(
          title: Text(subject),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => QuizScreen(subject: subject),
            ));
          },
        )).toList(),
      ),
    );
  }
}
