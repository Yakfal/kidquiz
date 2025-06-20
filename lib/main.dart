import 'package:flutter/material.dart';
import 'screens/subject_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidQuiz',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        fontFamily: 'Comic',
      ),
      home: SubjectScreen(),
    );
  }
}
