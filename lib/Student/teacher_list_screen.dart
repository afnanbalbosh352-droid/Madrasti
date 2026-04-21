import 'package:flutter/material.dart';
import 'chat_screen.dart'; 
import '../General/app_colors.dart';

class TeacherListScreen extends StatelessWidget {
  const TeacherListScreen({super.key});

  // قائمة المدرسين (بيانات للعرض فقط حالياً)
  final List<Map<String, String>> teachers = const [
    {"name": "Mr. Ahmad Ali", "subject": "Mathematics", "initial": "A"},
    {"name": "Ms. Sara Omar", "subject": "Science", "initial": "S"},
    {"name": "Mr. Khaled Jaber", "subject": "English", "initial": "K"},
    {"name": "Ms. Reem Ali", "subject": "Arabic", "initial": "R"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Teacher"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.8),
                child: Text(
                  teachers[index]['initial']!,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                teachers[index]['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(teachers[index]['subject']!),
              trailing: const Icon(Icons.chat_bubble_outline, color: Colors.blue),
              onTap: () {
                // نأخذ الطالب من هنا لشاشة الشات ونرسل له اسم المدرس المختار
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      teacherName: teachers[index]['name']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}