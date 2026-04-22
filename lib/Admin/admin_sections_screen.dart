import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminSectionsScreen extends StatefulWidget {
  const AdminSectionsScreen({super.key});

  @override
  State<AdminSectionsScreen> createState() => _AdminSectionsScreenState();
}

class _AdminSectionsScreenState extends State<AdminSectionsScreen> {
  final sectionController = TextEditingController();
  
  // بيانات تجريبية للمعلمين والمواد (يمكنك جلبها لاحقاً من Firebase)
  final List<String> teachers = ["Mr. Ahmad", "Ms. Sara", "Mr. Khalid", "Ms. Noor"];
  final List<String> subjects = ["Math", "Science", "English", "Arabic", "History"];

  String? selectedTeacher;
  String? selectedSubject;

  // 🎯 تعديل بنية البيانات لتشمل تفاصيل المعلم والمادة
  final Map<String, List<Map<String, String>>> school = {
    "Tenth": [
      {"name": "A", "teacher": "Mr. Ahmad", "subject": "Math"},
      {"name": "B", "teacher": "Ms. Sara", "subject": "Science"},
    ],
    "Ninth": [
      {"name": "A", "teacher": "Mr. Khalid", "subject": "English"},
    ],
  };

  String selectedGrade = "Tenth";
  List<Map<String, String>> get sections => school[selectedGrade]!;

  void addSection() {
    if (sectionController.text.isEmpty || selectedTeacher == null || selectedSubject == null) return;

    setState(() {
      school[selectedGrade]!.add({
        "name": sectionController.text,
        "teacher": selectedTeacher!,
        "subject": selectedSubject!,
      });
      _clearInputs();
    });
  }

  void _clearInputs() {
    sectionController.clear();
    selectedTeacher = null;
    selectedSubject = null;
  }

  void deleteSection(int index) {
    setState(() {
      school[selectedGrade]!.removeAt(index);
    });
  }

  // نافذة الإضافة والتعديل الموحدة
  void showSectionDialog({int? index}) {
    bool isEditing = index != null;
    if (isEditing) {
      sectionController.text = sections[index]["name"]!;
      selectedTeacher = sections[index]["teacher"];
      selectedSubject = sections[index]["subject"];
    } else {
      _clearInputs();
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder( // لاستخدام setState داخل الـ Dialog
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? "Edit Section" : "Add New Section"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: sectionController,
                  decoration: const InputDecoration(labelText: "Section Name (e.g. C)"),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedTeacher,
                  hint: const Text("Select Teacher"),
                  items: teachers.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (val) => setDialogState(() => selectedTeacher = val),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedSubject,
                  hint: const Text("Select Subject"),
                  items: subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (val) => setDialogState(() => selectedSubject = val),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  setState(() {
                    school[selectedGrade]![index] = {
                      "name": sectionController.text,
                      "teacher": selectedTeacher!,
                      "subject": selectedSubject!,
                    };
                  });
                } else {
                  addSection();
                }
                Navigator.pop(context);
              },
              child: Text(isEditing ? "Save" : "Add"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Sections Management")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => showSectionDialog(),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedGrade,
              decoration: const InputDecoration(labelText: "Select Class", border: OutlineInputBorder()),
              items: school.keys.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (val) => setState(() => selectedGrade = val!),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: sections.length,
                itemBuilder: (_, i) {
                  final s = sections[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                        child: Icon(Icons.group, color: AppColors.primary),
                      ),
                      title: Text("Section ${s['name']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Teacher: ${s['teacher']}"),
                          Text("Subject: ${s['subject']}", style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => showSectionDialog(index: i),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteSection(i),
                          ),
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