import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminActivitiesScreen extends StatefulWidget {
  const AdminActivitiesScreen({super.key});

  @override
  State<AdminActivitiesScreen> createState() =>
      _AdminActivitiesApprovalScreenState();
}

class _AdminActivitiesApprovalScreenState
    extends State<AdminActivitiesScreen> {
  
  // 🎯 الأنشطة القادمة من المعلمين (تحتاج موافقة)
  List<Map<String, dynamic>> teacherRequests = [
    {
      "title": "Scientific Trip",
"desc": "Visit to the Science Museum",
"grade": "Tenth",
"section": "A",
"subject": "Science",
"teacher": "Mr. Khaled",
"status": "Pending",
},
{
"title": "Math Competition",
"desc": "Group problem solving",
"grade": "Ninth",
"section": "A",
"subject": "Math",
"teacher": "Ms. Sarah",
"status": "Pending",
},
];

// 🏛️ School general events (added directly by admin)
List<Map<String, dynamic>> schoolEvents = [
{
"title": "Flag Day",
"desc": "Celebrating Jordanian Flag Day",
"date": "2026-04-16",
},
];

  final titleController = TextEditingController();
  final descController = TextEditingController();

  void approve(int index) {
    setState(() {
      teacherRequests[index]["status"] = "Approved";
    });
  }

  void reject(int index) {
    setState(() {
      teacherRequests[index]["status"] = "Rejected";
    });
  }

  void addSchoolEvent() {
    if (titleController.text.isEmpty) return;
    setState(() {
      schoolEvents.add({
        "title": titleController.text,
        "desc": descController.text,
        "date": DateTime.now().toString().split(' ')[0],
      });
      titleController.clear();
      descController.clear();
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Approved": return Colors.green;
      case "Rejected": return Colors.red;
      default: return Colors.orange;
    }
  }

  // نافذة إضافة نشاط عام جديد
  void showAddEventDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add School Event"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Event Title")),
            TextField(controller: descController, decoration: const InputDecoration(labelText: "Description")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              addSchoolEvent();
              Navigator.pop(context);
            },
            child: const Text("Post"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text("School Activities"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Teacher Requests", icon: Icon(Icons.pending_actions)),
              Tab(text: "School Events", icon: Icon(Icons.campaign)),
            ],
          ),
        ),
        
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: showAddEventDialog,
          child: const Icon(Icons.add_alert),
        ),

        body: TabBarView(
          children: [
            // التبويب الأول: طلبات المعلمين
            buildTeacherRequestsList(),
            // التبويب الثاني: أنشطة المدرسة العامة
            buildSchoolEventsList(),
          ],
        ),
      ),
    );
  }

  Widget buildTeacherRequestsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: teacherRequests.length,
      itemBuilder: (_, i) {
        final a = teacherRequests[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a["title"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(a["desc"]),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Teacher: ${a["teacher"]}", style: const TextStyle(fontSize: 12)),
                        Text("${a["grade"]} - ${a["section"]}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    Row(
                      children: [
                        if (a["status"] == "Pending") ...[
                          IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => approve(i)),
                          IconButton(icon: const Icon(Icons.close, color: Colors.red), onPressed: () => reject(i)),
                        ] else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: getStatusColor(a["status"]).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(a["status"], style: TextStyle(color: getStatusColor(a["status"]), fontWeight: FontWeight.bold)),
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
    );
  }

  Widget buildSchoolEventsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schoolEvents.length,
      itemBuilder: (_, i) {
        final e = schoolEvents[i];
        return Card(
          color: Colors.blue.shade50, 
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: AppColors.primary, width: 1)),
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.star, color: Colors.orange)),
            title: Text(e["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(e["desc"]),
            trailing: Text(e["date"], style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ),
        );
      },
    );
  }
}