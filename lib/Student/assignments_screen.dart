import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AssignmentsScreen extends StatelessWidget {
  AssignmentsScreen({super.key});

  final List<Map<String, String>> assignments = [
   
  {
    "title": "Math Homework",
    "desc": "Solve exercises on page 25",
    "due": "2026-04-22"
  },
  {
    "title": "Science Homework",
    "desc": "Summarize the Energy lesson",
    "due": "2026-04-24"
  },
  {
    "title": "English Homework",
    "desc": "Write a paragraph about traveling",
    "due": "2026-04-26"
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignment")),
      backgroundColor: AppColors.background,

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: assignments.length,
        itemBuilder: (_, i) {
          final a = assignments[i];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 📅 التاريخ
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 18, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        "Submission: ${a["due"]}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // 🏷️ العنوان
                  Text(
                    a["title"]!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 📝 الوصف
                  Text(
                    a["desc"]!,
                    style: const TextStyle(color: Colors.black87),
                  ),

                  const SizedBox(height: 12),

                  // 🔘 زر (اختياري)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("The Assignment has been opened")),
                        );
                      },
                      child: const Text("View"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}