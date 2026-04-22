import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() => _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  
  // خيارات المستقبلين المفصلة كما طلبتِ
  String selectedRecipient = "All School"; 
  final List<String> recipientOptions = [
    "All School",
    "All Teachers",
    "All Students",
    "Tenth Grade (All)",
    "Tenth Grade (A)",
    "Tenth Grade (B)",
    "Ninth Grade (All)",
  ];

  final List<Map<String, String>> announcementHistory = [
    {
      "title": "Final Exams Schedule",
      "message": "The final exam schedule has been uploaded for all grades.",
      "date": "2026-04-22",
      "to": "All School"
    },
    {
      "title": "Urgent: Teacher Meeting",
      "message": "Meeting in the library at 1:00 PM for all staff.",
      "date": "2026-04-21",
      "to": "All Teachers"
    },
  ];

  void _sendNotification() {
    if (_titleController.text.isNotEmpty && _messageController.text.isNotEmpty) {
      setState(() {
        announcementHistory.insert(0, {
          "title": _titleController.text,
          "message": _messageController.text,
          "date": DateTime.now().toString().split(' ')[0],
          "to": selectedRecipient,
        });
      });
      _titleController.clear();
      _messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notification Sent Successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Notifications Management")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Send New Notification", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
            const SizedBox(height: 12),
            
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // قائمة اختيار المستقبلين المفصلة
                    DropdownButtonFormField<String>(
                      initialValue: selectedRecipient,
                      decoration: const InputDecoration(
                        labelText: "Send To",
                        prefixIcon: Icon(Icons.person_search),
                      ),
                      items: recipientOptions.map((val) => 
                        DropdownMenuItem(value: val, child: Text(val))).toList(),
                      onChanged: (val) => setState(() => selectedRecipient = val!),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        prefixIcon: Icon(Icons.label_important),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _messageController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Message",
                        hintText: "Type your announcement here...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _sendNotification,
                        icon: const Icon(Icons.send_rounded, color: Colors.white),
                        label: const Text("Broadcast Now", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Text("Recent Notifications", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),

            // عرض تاريخ الإشعارات مع توضيح الفئة المستهدفة
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: announcementHistory.length,
              itemBuilder: (context, index) {
                final item = announcementHistory[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: const Icon(Icons.notifications, size: 20),
                    ),
                    title: Text(item["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item["message"]!),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Target: ${item["to"]}", 
                                style: const TextStyle(fontSize: 11, color: Colors.blue, fontWeight: FontWeight.w600)),
                            Text(item["date"]!, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}