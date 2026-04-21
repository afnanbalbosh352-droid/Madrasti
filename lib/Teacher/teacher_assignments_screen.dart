import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class TeacherAssignmentsScreen extends StatefulWidget {
  const TeacherAssignmentsScreen({super.key});

  @override
  State<TeacherAssignmentsScreen> createState() =>
      _TeacherAssignmentsScreenState();
}

class _TeacherAssignmentsScreenState
    extends State<TeacherAssignmentsScreen> {

  final titleController = TextEditingController();
  final descController = TextEditingController();

  DateTime? selectedDate;

  // 🎯 هيكل المدرسة
 final Map<String, Map<String, List<String>>> school = {
  "Tenth": {
    "A": ["Ahmed", "Mohammad"],
    "B": ["Ali", "Sara"],
  },
  "Ninth": {
    "A": ["Layan", "Yousef"],
  }
};

String selectedGrade = "Tenth";
String selectedSection = "A";
String selectedSubject = "Math";

final List<String> subjects = ["Math", "Science", "English"];
  List<Map<String, dynamic>> assignments = [];

  List<String> get sections => school[selectedGrade]!.keys.toList();

  void pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  void addAssignment() {
    if (titleController.text.isEmpty ||
        descController.text.isEmpty ||
        selectedDate == null) {
      return;
    }

    setState(() {
      assignments.add({
        "grade": selectedGrade,
        "section": selectedSection,
        "subject": selectedSubject,
        "title": titleController.text,
        "desc": descController.text,
        "date": selectedDate,
      });

      titleController.clear();
      descController.clear();
      selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Assignments Management")),

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

                    // 🎓 الصف
                    DropdownButtonFormField(
                      initialValue: selectedGrade,
                      decoration: const InputDecoration(labelText: "Class"),
                      items: school.keys.map((g) {
                        return DropdownMenuItem(value: g, child: Text(g));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedGrade = val!;
                          selectedSection = school[val]!.keys.first;
                        });
                      },
                    ),

                    const SizedBox(height: 10),

                    // 🏫 الشعبة
                    DropdownButtonFormField(
                      initialValue: selectedSection,
                      decoration: const InputDecoration(labelText: "Section"),
                      items: sections.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => selectedSection = val!),
                    ),

                    const SizedBox(height: 10),

                    // 📚 المادة
                    DropdownButtonFormField(
                      initialValue: selectedSubject,
                      decoration: const InputDecoration(labelText: "Course"),
                      items: subjects.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => selectedSubject = val!),
                    ),

                    const SizedBox(height: 10),

                    // 🏷️ العنوان
                    TextField(
                      controller: titleController,
                      decoration:
                      const InputDecoration(labelText: "Assignment Title"),
                    ),

                    const SizedBox(height: 10),

                    // 📝 الوصف
                    TextField(
                      controller: descController,
                      decoration:
                      const InputDecoration(labelText: "Assignment Description"),
                    ),

                    const SizedBox(height: 10),

                    // 📅 التاريخ
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedDate == null
                                ? "Choose Due date"
                                : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                          ),
                        ),
                        TextButton(
                          onPressed: pickDate,
                          child: const Text("Choose"),
                        )
                      ],
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: addAssignment,
                      child: const Text("Add Assignment"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 📋 LIST
            Expanded(
              child: ListView.builder(
                itemCount: assignments.length,
                itemBuilder: (_, i) {
                  final a = assignments[i];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading:
                      Icon(Icons.assignment, color: AppColors.primary),

                      title: Text(a["title"]),

                      subtitle: Text(
                        "${a["grade"]} - ${a["section"]}\n"
                            "Course: ${a["subject"]}\n"
                            "Due date: ${a["date"].year}-${a["date"].month}-${a["date"].day}\n"
                            "${a["desc"]}",
                      ),
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