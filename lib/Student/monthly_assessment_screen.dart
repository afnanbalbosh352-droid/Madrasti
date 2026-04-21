import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class MonthlyAssessmentScreen extends StatelessWidget {
  MonthlyAssessmentScreen({super.key});

  // 🎯 بيانات وهمية من المعلم
  final List<Map<String, dynamic>> assessments = [
    {
      "month": "April",
      "subject": "Maths",
      "grade": 90,
      "note": "Exellent"
    },
    {
      "month": "April",
      "subject": "Sciences",
      "grade": 85,
      "note": "Very Good"
    },
    {
      "month": "April",
      "subject": "English",
      "grade": 70,
      "note": "good"
    },
    {
      "month": "April",
      "subject": "Computer",
      "grade": 60,
      "note": "Need to focus more"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Monthly Assessment")),
      backgroundColor: AppColors.background,

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: assessments.length,
        itemBuilder: (_, i) {
          final a = assessments[i];

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

                  // 📅 الشهر
                  Row(
                    children: [
                      Icon(Icons.calendar_month,
                          color: AppColors.primary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        a["month"],
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // 🏷️ المادة
                  Text(
                    a["subject"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 📊 العلامة
                  Row(
                    children: [
                      const Text("Assessment: "),
                      Text(
                        "${a["grade"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: a["grade"] >= 90
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // 📝 ملاحظة المعلم
                  Text(
                    a["note"],
                    style: const TextStyle(color: Colors.black87),
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