import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  List<Map<String, dynamic>> notifications = [
    {
      "title": "واجب جديد",
      "message": "تم إضافة واجب رياضيات",
      "type": "assignment",
      "time": "قبل 10 دقائق",
      "read": false,
    },
    {
      "title": "تنبيه امتحان",
      "message": "غدًا امتحان علوم",
      "type": "exam",
      "time": "قبل ساعة",
      "read": false,
    },
    {
      "title": "إعلان",
      "message": "عطلة رسمية يوم الخميس",
      "type": "announcement",
      "time": "اليوم",
      "read": true,
    },
  ];

  IconData getIcon(String type) {
    switch (type) {
      case "assignment":
        return Icons.assignment;
      case "exam":
        return Icons.school;
      case "announcement":
        return Icons.campaign;
      default:
        return Icons.notifications;
    }
  }

  void markAsRead(int index) {
    setState(() {
      notifications[index]["read"] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("الإشعارات")),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (_, i) {
          final n = notifications[i];

          return GestureDetector(
            onTap: () => markAsRead(i),

            child: Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: n["read"] ? 1 : 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(

                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Icon(
                    getIcon(n["type"]),
                    color: AppColors.primary,
                  ),
                ),

                title: Text(
                  n["title"],
                  style: TextStyle(
                    fontWeight: n["read"]
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(n["message"]),
                    const SizedBox(height: 4),
                    Text(
                      n["time"],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                trailing: n["read"]
                    ? null
                    : Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}