import 'package:flutter/material.dart';
import 'app_colors.dart'; 

class ScheduleExamScreen extends StatelessWidget {
  final String teacherSubject; 

  const ScheduleExamScreen({super.key, required this.teacherSubject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Exam Schedule",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.gradient),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Text(
                teacherSubject == "All" 
                    ? "Full Academic Exam Schedule" 
                    : "Personal Schedule for $teacherSubject Teacher",
                style: const TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold, 
                  color: AppColors.primary
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  // --- SUNDAY (May 12) ---
                  if (teacherSubject == "Mathematics" || teacherSubject == "All")
                    _buildExamCard("Mathematics", "10th", "A", "Sunday", "2024-05-12", "09:00 AM"),
                  
                  if (teacherSubject == "Arabic" || teacherSubject == "All")
                    _buildExamCard("Arabic", "9th", "B", "Sunday", "2024-05-12", "11:30 AM"),

                  // --- MONDAY (May 13) ---
                  if (teacherSubject == "English" || teacherSubject == "All")
                    _buildExamCard("English", "12th", "C", "Monday", "2024-05-13", "08:30 AM"),

                  // --- TUESDAY (May 14) ---
                  if (teacherSubject == "Physics" || teacherSubject == "All")
                    _buildExamCard("Physics", "11th", "B", "Tuesday", "2024-05-14", "10:00 AM"),
                  
                  if (teacherSubject == "History" || teacherSubject == "All")
                    _buildExamCard("History", "10th", "A", "Tuesday", "2024-05-14", "01:00 PM"),

                  // --- WEDNESDAY (May 15) ---
                  if (teacherSubject == "Biology" || teacherSubject == "All")
                    _buildExamCard("Biology", "12th", "A", "Wednesday", "2024-05-15", "09:00 AM"),

                  // --- THURSDAY (May 16) ---
                  if (teacherSubject == "Chemistry" || teacherSubject == "All")
                    _buildExamCard("Chemistry", "10th", "B", "Thursday", "2024-05-16", "09:00 AM"),
                  
                  if (teacherSubject == "Computer Science" || teacherSubject == "All")
                    _buildExamCard("Computer Science", "11th", "A", "Thursday", "2024-05-16", "11:30 AM"),

                  // --- Message if no specialization matches ---
                  if (teacherSubject != "All" && 
                      !["Mathematics", "Arabic", "English", "Physics", "History", "Biology", "Chemistry", "Computer Science"].contains(teacherSubject))
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text("No exams scheduled for your subject."),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة بناء كرت الامتحان بشكل احترافي
  Widget _buildExamCard(String subject, String grade, String section, String day, String date, String time) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject, 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Grade: $grade ($section)", 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                  ),
                ),
              ],
            ),
            const Divider(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn(Icons.calendar_today_outlined, day, date),
                _buildInfoColumn(Icons.access_time_rounded, "Time", time),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}