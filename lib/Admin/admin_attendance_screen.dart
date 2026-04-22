import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminAttendanceScreen extends StatefulWidget {
  const AdminAttendanceScreen({super.key});

  @override
  State<AdminAttendanceScreen> createState() => _AdminAttendanceScreenState();
}

class _AdminAttendanceScreenState extends State<AdminAttendanceScreen> {
  // 🎯 Mock Data
  final List<Map<String, dynamic>> atRiskStudents = [
    {"id": "s1", "name": "Zaid Ali", "absences": 9, "class": "10-A"},
    {"id": "s2", "name": "Mona Omar", "absences": 7, "class": "9-B"},
  ];

  final Map<String, Map<String, List<Map<String, String>>>> schoolData = {
    "Tenth": {
      "A": [
        {"id": "1", "name": "Ahmed", "status": "Present"},
        {"id": "2", "name": "Mohamed", "status": "Absent"},
        {"id": "3", "name": "Ali", "status": "Late"},
      ],
      "B": [
        {"id": "4", "name": "Sarah", "status": "Present"},
        {"id": "5", "name": "Layan", "status": "Present"},
      ],
    },
    "Ninth": {
      "A": [
        {"id": "6", "name": "Youssef", "status": "Absent"},
        {"id": "7", "name": "Rami", "status": "Present"},
      ],
    },
  };

  String selectedGrade = "Tenth";
  String selectedSection = "A";

  void sendWarningNotification(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Warning Notification sent to $name!"),
        backgroundColor: Colors.orange.shade800,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Attendance records finalized and saved!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Present": return Colors.green;
      case "Absent": return Colors.red;
      case "Late": return Colors.orange;
      case "Excused": return Colors.blue;
      default: return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    // جلب القائمة الحالية بناءً على الاختيار
    List<Map<String, String>> currentStudents = schoolData[selectedGrade]![selectedSection]!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Attendance Correction"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 SECTION 1: AT RISK STUDENTS
            if (atRiskStudents.isNotEmpty) ...[
              const Text(
                "Students at Risk (High Absence)",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: ExpansionTile(
                  leading: const Icon(Icons.warning_amber_rounded, color: Colors.red),
                  title: Text(
                    "Action Required: ${atRiskStudents.length} Students",
                    style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  children: atRiskStudents.map((student) {
                    return ListTile(
                      title: Text(student["name"], style: const TextStyle(fontSize: 14)),
                      subtitle: Text("Absences: ${student["absences"]} days | ${student["class"]}", 
                          style: const TextStyle(fontSize: 12)),
                      trailing: ElevatedButton.icon(
                        onPressed: () => sendWarningNotification(student["name"]),
                        icon: const Icon(Icons.notifications_active, size: 16, color: Colors.white),
                        label: const Text("Warn", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // 📦 SECTION 2: CLASS NAVIGATION
            const Text(
              "Review Teacher Lists",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedGrade,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: schoolData.keys.map((g) {
                          return DropdownMenuItem(value: g, child: Text("Grade $g"));
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedGrade = val!;
                            selectedSection = schoolData[val]!.keys.first;
                          });
                        },
                      ),
                    ),
                    const Text(" | "),
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedSection,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: schoolData[selectedGrade]!.keys.map((s) {
                          return DropdownMenuItem(value: s, child: Text("Section $s"));
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedSection = val!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 📋 SECTION 3: LIST
            Expanded(
              child: ListView.builder(
                itemCount: currentStudents.length,
                itemBuilder: (context, index) {
                  final student = currentStudents[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(student["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Current: ${student["status"]}", 
                          style: TextStyle(color: _getStatusColor(student["status"]!), fontSize: 12)),
                      trailing: DropdownButton<String>(
                        value: student["status"],
                        underline: const SizedBox(),
                        onChanged: (newStatus) {
                          setState(() {
                            student["status"] = newStatus!;
                          });
                        },
                        items: ["Present", "Absent", "Late", "Excused"].map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text(status, 
                                style: TextStyle(color: _getStatusColor(status), fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 💾 SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: saveChanges,
                child: const Text("Confirm & Sync to Firebase", 
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}