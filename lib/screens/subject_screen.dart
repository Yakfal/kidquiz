import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import '../sound/sound_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectScreen extends StatelessWidget {
  final List<Map<String, dynamic>> subjects = [
    {'name': 'Math', 'icon': Icons.calculate, 'color': Colors.blue},
    {'name': 'Animals & Nature', 'icon': Icons.nature, 'color': Colors.green},
    {'name': 'Science', 'icon': Icons.science, 'color': Colors.orange},
    {'name': 'History', 'icon': Icons.history_edu, 'color': Colors.red},
    // Add more as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4F1),
      appBar: AppBar(
        title: Text(
          'Choose a Subject',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: subjects.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return GestureDetector(
              onTap: () {
                SoundManager.playClickSound();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(subject: subject['name']),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: subject['color'].withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: subject['color'].withOpacity(0.5),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(subject['icon'], size: 50, color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      subject['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
