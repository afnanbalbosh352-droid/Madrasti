import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState
    extends State<AdminNotificationsScreen> {

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  String selectedTarget = "All";

  String selectedGrade = "العاشر";
  String selectedSection = "أ";

  final List<String> targets = [
    "All",
    "Students",
    "Teachers",
    "Grade",
    "Section",
  ];

  final List<String> grades = ["العاشر", "التاسع"];
  final List<String> sections = ["أ", "ب"];

  List<Map<String, String>> notifications = [];

  void sendNotification() {
    if (titleController.text.isEmpty ||
        bodyController.text.isEmpty) {
      return;
    }

    String targetText = selectedTarget;

    if (selectedTarget == "Grade") {
      targetText = "صف $selectedGrade";
    } else if (selectedTarget == "Section") {
      targetText = "شعبة $selectedGrade - $selectedSection";
    }

    setState(() {
      notifications.add({
        "title": titleController.text,
        "body": bodyController.text,
        "target": targetText,
      });

      titleController.clear();
      bodyController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Notifications")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 📦 FORM
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    // 🏷️ Title
                    TextField(
                      controller: titleController,
                      decoration:
                      const InputDecoration(labelText: "Title"),
                    ),

                    const SizedBox(height: 10),

                    // 📝 Body
                    TextField(
                      controller: bodyController,
                      decoration:
                      const InputDecoration(labelText: "Message"),
                    ),

                    const SizedBox(height: 10),

                    // 🎯 Target Type
                    DropdownButtonFormField(
                      initialValue: selectedTarget,
                      decoration:
                      const InputDecoration(labelText: "Send To"),
                      items: targets.map((t) {
                        return DropdownMenuItem(
                            value: t, child: Text(t));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => selectedTarget = val!),
                    ),

                    const SizedBox(height: 10),

                    // 🎓 إذا Grade
                    if (selectedTarget == "Grade")
                      DropdownButtonFormField(
                        initialValue: selectedGrade,
                        decoration:
                        const InputDecoration(labelText: "Select Grade"),
                        items: grades.map((g) {
                          return DropdownMenuItem(
                              value: g, child: Text(g));
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => selectedGrade = val!),
                      ),

                    // 🏫 إذا Section
                    if (selectedTarget == "Section") ...[
                      DropdownButtonFormField(
                        initialValue: selectedGrade,
                        decoration:
                        const InputDecoration(labelText: "Grade"),
                        items: grades.map((g) {
                          return DropdownMenuItem(
                              value: g, child: Text(g));
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => selectedGrade = val!),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        initialValue: selectedSection,
                        decoration:
                        const InputDecoration(labelText: "Section"),
                        items: sections.map((s) {
                          return DropdownMenuItem(
                              value: s, child: Text(s));
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => selectedSection = val!),
                      ),
                    ],

                    const SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: sendNotification,
                      child: const Text("Send Notification"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 📋 LIST
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (_, i) {
                  final n = notifications[i];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.notifications,
                          color: AppColors.primary),
                      title: Text(n["title"]!),
                      subtitle: Text(
                          "${n["body"]}\nTarget: ${n["target"]}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}