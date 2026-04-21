import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminAssignmentsScreen extends StatefulWidget {
  const AdminAssignmentsScreen({super.key});

  @override
  State<AdminAssignmentsScreen> createState() =>
      _AdminAssignmentsScreenState();
}

class _AdminAssignmentsScreenState
    extends State<AdminAssignmentsScreen> {

  // 🎯 بيانات وهمية (جاية من المعلمين)
  List<Map<String, dynamic>> assignments = [
    {
      "title": "Homework 1",
      "desc": "حل تمارين صفحة 20",
      "grade": "العاشر",
      "section": "أ",
      "subject": "رياضيات",
      "status": "Pending",
    },
    {
      "title": "Homework 2",
      "desc": "ملخص درس الطاقة",
      "grade": "التاسع",
      "section": "أ",
      "subject": "علوم",
      "status": "Pending",
    },
  ];

  void approve(int index) {
    setState(() {
      assignments[index]["status"] = "Approved";
    });
  }

  void reject(int index) {
    setState(() {
      assignments[index]["status"] = "Rejected";
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Assignments Review")),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: assignments.length,
        itemBuilder: (_, i) {
          final a = assignments[i];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 🏷️ Title
                  Text(
                    a["title"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // 📝 Description
                  Text(a["desc"]),

                  const SizedBox(height: 8),

                  // 📚 Info
                  Text(
                    "${a["grade"]} - ${a["section"]} | ${a["subject"]}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 8),

                  // 📊 Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: getStatusColor(a["status"])
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          a["status"],
                          style: TextStyle(
                            color: getStatusColor(a["status"]),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // 🔘 Actions
                      if (a["status"] == "Pending")
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check,
                                  color: Colors.green),
                              onPressed: () => approve(i),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.red),
                              onPressed: () => reject(i),
                            ),
                          ],
                        ),
                    ],
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