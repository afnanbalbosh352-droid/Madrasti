import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class ScheduleExamScreen extends StatelessWidget {
  ScheduleExamScreen({super.key});

  final List<Map<String, String>> exams = [
    {"date": "2026-05-10", "subject": "Maths", "time": "10:00 AM"},
    {"date": "2026-05-12", "subject": "Science", "time": "9:00 AM"},
    {"date": "2026-05-15", "subject": "English", "time": "11:00 AM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exam Schedule")),
      backgroundColor: AppColors.background,

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exams.length,
        itemBuilder: (_, i) {
          final exam = exams[i];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.event, color: AppColors.primary),
              title: Text(exam["subject"]!),
              subtitle: Text("${exam["date"]} - ${exam["time"]}"),
            ),
          );
        },
      ),
    );
  }
}