import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class ActivitiesTeacherScreen extends StatefulWidget {
  const ActivitiesTeacherScreen({super.key});

  @override
  State<ActivitiesTeacherScreen> createState() => _ActivitiesTeacherScreenState();
}

class _ActivitiesTeacherScreenState extends State<ActivitiesTeacherScreen> {

  final titleController = TextEditingController();
  final descController = TextEditingController();

  // 🎯 هيكل المدرسة
  String selectedGrade = "Tenth";
String selectedSection = "A";
String selectedSubject = "Math";

final List<String> grades = ["Tenth", "Ninth"];
final List<String> sections = ["A", "B"];
final List<String> subjects = ["Math", "Science", "English"];
  List<Map<String, String>> activities = [];

  void addActivity() {
    if (titleController.text.isEmpty || descController.text.isEmpty) return;

    setState(() {
      activities.add({
        "grade": selectedGrade,
        "section": selectedSection,
        "subject": selectedSubject,
        "title": titleController.text,
        "desc": descController.text,
      });

      titleController.clear();
      descController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Activities Management")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 📦 Form Card
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
                      items: grades.map((g) {
                        return DropdownMenuItem(value: g, child: Text(g));
                      }).toList(),
                      onChanged: (val) => setState(() => selectedGrade = val!),
                    ),

                    const SizedBox(height: 10),

                    // 🏫 الشعبة
                    DropdownButtonFormField(
                      initialValue: selectedSection,
                      decoration: const InputDecoration(labelText: "Section"),
                      items: sections.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) => setState(() => selectedSection = val!),
                    ),

                    const SizedBox(height: 10),

                    // 📚 المادة
                    DropdownButtonFormField(
                      initialValue: selectedSubject,
                      decoration: const InputDecoration(labelText: "Course"),
                      items: subjects.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) => setState(() => selectedSubject = val!),
                    ),

                    const SizedBox(height: 10),

                    // 🏷️ العنوان
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                     labelText: "Activity Title",
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 📝 الوصف
                    TextField(
                      controller: descController,
                      decoration: const InputDecoration(
                      labelText: "Activity Description",
                      ),
                    ),

                    const SizedBox(height: 15),

                    // 🔘 زر
                    ElevatedButton(
                      onPressed: addActivity,
                    child: const Text("Add Activity"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📋 عرض الأنشطة
            Expanded(
              child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (_, i) {
                  final a = activities[i];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.event, color: AppColors.primary),

                      title: Text(a["title"]!),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${a["grade"]} - ${a["section"]}"),
                          Text("Course: ${a["subject"]}"),
                          Text(a["desc"]!),
                        ],
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