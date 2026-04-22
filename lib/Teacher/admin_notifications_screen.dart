import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminNotificationsScreen extends StatelessWidget {
  const AdminNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // هذه بيانات تجريبية (Mock Data) لما قد يرسله الإدمن
    final List<Map<String, String>> adminMessages = [
      {
        "title": "Staff Meeting",
        "body": "Urgent meeting tomorrow at 9:00 AM in the library.",
        "time": "2h ago"
      },
      {
        "title": "Grades Deadline",
        "body": "Please upload all midterm grades by Thursday.",
        "time": "Today"
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Admin Notifications"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: adminMessages.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: const Icon(Icons.admin_panel_settings, color: AppColors.primary),
              ),
              title: Text(adminMessages[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(adminMessages[index]['body']!),
                  Text(adminMessages[index]['time']!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}