import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Activities")),
      backgroundColor: AppColors.background,

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          buildActivity(
  "2026-04-20",
  "School Trip",
  "A trip to the archaeological city of Jerash for 10th-grade students.",
),

buildActivity(
  "2026-04-25",
  "Math Competition",
  "School-wide competition for outstanding students.",
),

buildActivity(
  "2026-05-01",
  "Open Day",
  "Entertainment and sports activities within the school.",
),
        ],
      ),
    );
  }

  Widget buildActivity(String date, String title, String desc) {
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
                Icon(Icons.calendar_today, size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 10),

            // 🏷️ العنوان
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 8),

            // 📝 الوصف
            Text(
              desc,
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}