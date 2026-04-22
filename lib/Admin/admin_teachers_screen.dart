import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminTeachersScreen extends StatefulWidget {
  const AdminTeachersScreen({super.key});

  @override
  State<AdminTeachersScreen> createState() =>
      _AdminTeachersScreenState();
}

class _AdminTeachersScreenState
    extends State<AdminTeachersScreen> {

  final nameController = TextEditingController();
  final idController = TextEditingController();

  // 🎯 بيانات النظام
  final Map<String, List<String>> school = {
  "Tenth": ["A", "B"],
  "Ninth": ["A"],
};

final List<String> subjects = [
  "Math",
  "Science",
  "English",
  "Arabic"
];

String selectedGrade = "Tenth";
String selectedSection = "A";
String selectedSubject = "Math";

  List<Map<String, dynamic>> teachers = [
    {
      "name": "Mr. Khaled",
"id": "444",
"grade": "Tenth",
"section": "A",
"subject": "Math"
    }
  ];

  List<String> get sections => school[selectedGrade]!;

  void addTeacher() {
    if (nameController.text.isEmpty || idController.text.isEmpty) return;

    setState(() {
      teachers.add({
        "name": nameController.text,
        "id": idController.text,
        "grade": selectedGrade,
        "section": selectedSection,
        "subject": selectedSubject,
      });

      nameController.clear();
      idController.clear();
    });
  }

  void deleteTeacher(int index) {
    setState(() {
      teachers.removeAt(index);
    });
  }

  void editTeacher(int index) {
    final t = teachers[index];

    nameController.text = t["name"];
    idController.text = t["id"];
    selectedGrade = t["grade"];
    selectedSection = t["section"];
    selectedSubject = t["subject"];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Teacher"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: "National ID"),
            ),

            DropdownButtonFormField(
              initialValue: selectedGrade,
              items: school.keys.map((g) {
                return DropdownMenuItem(value: g, child: Text(g));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedGrade = val!;
                  selectedSection = school[val]![0];
                });
              },
            ),

            DropdownButtonFormField(
              initialValue: selectedSection,
              items: sections.map((s) {
                return DropdownMenuItem(value: s, child: Text(s));
              }).toList(),
              onChanged: (val) =>
                  setState(() => selectedSection = val!),
            ),

            DropdownButtonFormField(
              initialValue: selectedSubject,
              items: subjects.map((s) {
                return DropdownMenuItem(value: s, child: Text(s));
              }).toList(),
              onChanged: (val) =>
                  setState(() => selectedSubject = val!),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                teachers[index] = {
                  "name": nameController.text,
                  "id": idController.text,
                  "grade": selectedGrade,
                  "section": selectedSection,
                  "subject": selectedSubject,
                };
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Teacher"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: "National ID"),
            ),

            DropdownButtonFormField(
              initialValue: selectedGrade,
              items: school.keys.map((g) {
                return DropdownMenuItem(value: g, child: Text(g));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedGrade = val!;
                  selectedSection = school[val]![0];
                });
              },
            ),

            DropdownButtonFormField(
              initialValue: selectedSection,
              items: sections.map((s) {
                return DropdownMenuItem(value: s, child: Text(s));
              }).toList(),
              onChanged: (val) =>
                  setState(() => selectedSection = val!),
            ),

            DropdownButtonFormField(
              initialValue: selectedSubject,
              items: subjects.map((s) {
                return DropdownMenuItem(value: s, child: Text(s));
              }).toList(),
              onChanged: (val) =>
                  setState(() => selectedSubject = val!),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              addTeacher();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredTeachers {
    return teachers.where((t) {
      return t["grade"] == selectedGrade &&
          t["section"] == selectedSection;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Teachers Management"),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🎓 Filter
            Row(
              children: [

                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: selectedGrade,
                    decoration: const InputDecoration(labelText: "Grade"),
                    items: school.keys.map((g) {
                      return DropdownMenuItem(value: g, child: Text(g));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedGrade = val!;
                        selectedSection = school[val]![0];
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: selectedSection,
                    decoration: const InputDecoration(labelText: "Section"),
                    items: sections.map((s) {
                      return DropdownMenuItem(value: s, child: Text(s));
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => selectedSection = val!),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // 📋 List
            Expanded(
              child: ListView.builder(
                itemCount: filteredTeachers.length,
                itemBuilder: (_, i) {
                  final t = filteredTeachers[i];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading:
                      Icon(Icons.person, color: AppColors.primary),

                      title: Text(t["name"]),

                      subtitle: Text(
                          "ID: ${t["id"]} | ${t["subject"]} | ${t["grade"]}-${t["section"]}"),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.blue),
                            onPressed: () =>
                                editTeacher(teachers.indexOf(t)),
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () =>
                                deleteTeacher(teachers.indexOf(t)),
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