import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          buildNotification("Attention" ,"Pearents Meeting"),
          buildNotification("Attention","Notice of Student absence"),
          buildNotification("Attention", "Thursday is a public holiday"),

        ],
      ),
    );
  }

  Widget buildNotification(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(Icons.notifications, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}