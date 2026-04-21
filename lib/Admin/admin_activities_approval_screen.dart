import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminActivitiesApprovalScreen extends StatefulWidget {
  const AdminActivitiesApprovalScreen({super.key});

  @override
  State<AdminActivitiesApprovalScreen> createState() =>
      _AdminActivitiesApprovalScreenState();
}

class _AdminActivitiesApprovalScreenState
    extends State<AdminActivitiesApprovalScreen> {

  // 🎯 بيانات وهمية (جاية من المعلمين)
  List<Map<String, dynamic>> activities = [
    {
      "title": "رحلة علمية",
      "desc": "زيارة متحف العلوم",
      "grade": "العاشر",
      "section": "أ",
      "subject": "علوم",
      "teacher": "أستاذ خالد",
      "status": "Pending",
    },
    {
      "title": "مسابقة رياضيات",
      "desc": "حل مسائل جماعية",
      "grade": "التاسع",
      "section": "أ",
      "subject": "رياضيات",
      "teacher": "أستاذة سارة",
      "status": "Pending",
    },
  ];

  void approve(int index) {
    setState(() {
      activities[index]["status"] = "Approved";
    });
  }

  void reject(int index) {
    setState(() {
      activities[index]["status"] = "Rejected";
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
      appBar: AppBar(title: const Text("Activities Approval")),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: activities.length,
        itemBuilder: (_, i) {
          final a = activities[i];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(14),
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

                  const SizedBox(height: 10),

                  // 📚 Info
                  Row(
                    children: [
                      const Icon(Icons.school, size: 16),
                      const SizedBox(width: 5),
                      Text("${a["grade"]} - ${a["section"]}"),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(Icons.book, size: 16),
                      const SizedBox(width: 5),
                      Text(a["subject"]),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(Icons.person, size: 16),
                      const SizedBox(width: 5),
                      Text(a["teacher"]),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // 📊 Status + Actions
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