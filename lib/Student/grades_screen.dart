import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class GradesScreen extends StatelessWidget {
  GradesScreen({super.key});

  final List<Map<String, dynamic>> currentGrades = [
  {"subject": "Mathe", "grade": 95},
  {"subject": "Science", "grade": 88},
  {"subject": "English", "grade": 92},
];

final List<Map<String, dynamic>> previousGrades = [
  {"subject": "Mathe", "grade": 90},
  {"subject": "Science", "grade": 85},
  {"subject": "English", "grade": 87},
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grades")),
      backgroundColor: AppColors.background,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            buildSection("Current Semester", currentGrades),
            const SizedBox(height: 20),
            buildSection("Previous Semester", previousGrades),

          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Map<String, dynamic>> grades) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: 10),

        ...grades.map((g) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(g["subject"]),
              trailing: Text(
                "${g["grade"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: g["grade"] >= 90 ? Colors.green : Colors.orange,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}