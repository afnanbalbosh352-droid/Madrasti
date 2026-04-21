import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // 🎯 بيانات وهمية (مستقبلاً Firebase)
    final totalStudents = 120;
    final totalTeachers = 15;
    final attendanceRate = 87; // %
    final avgGrade = 82;

    final topStudents = [
      {"name": "أحمد", "grade": 98},
      {"name": "سارة", "grade": 95},
      {"name": "محمد", "grade": 93},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Reports Dashboard")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 📊 Overview Cards
            Row(
              children: [
                Expanded(child: buildStatCard("Students", totalStudents.toString(), Icons.people)),
                const SizedBox(width: 10),
                Expanded(child: buildStatCard("Teachers", totalTeachers.toString(), Icons.person)),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: buildStatCard("Attendance", "$attendanceRate%", Icons.fact_check)),
                const SizedBox(width: 10),
                Expanded(child: buildStatCard("Avg Grade", "$avgGrade", Icons.grade)),
              ],
            ),

            const SizedBox(height: 20),

            // 🏆 Top Students
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Top Students",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Column(
              children: topStudents.map((s) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.emoji_events, color: Colors.orange),
                    title: Text(s["name"].toString()),
                    trailing: Text(
                      s["grade"].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // 📊 Attendance Indicator
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Attendance Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: FractionallySizedBox(
                widthFactor: attendanceRate / 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            Text("$attendanceRate% Attendance Rate"),
          ],
        ),
      ),
    );
  }

  Widget buildStatCard(String title, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 30),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}