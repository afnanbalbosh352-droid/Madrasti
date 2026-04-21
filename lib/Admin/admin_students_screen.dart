import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminStudentsScreen extends StatefulWidget {
  const AdminStudentsScreen({super.key});

  @override
  State<AdminStudentsScreen> createState() =>
      _AdminStudentsScreenState();
}

class _AdminStudentsScreenState extends State<AdminStudentsScreen> {

  final nameController = TextEditingController();
  final idController = TextEditingController();

  // 🎯 هيكل المدرسة
  final Map<String, List<String>> school = {
    "العاشر": ["أ", "ب"],
    "التاسع": ["أ"],
  };

  String selectedGrade = "العاشر";
  String selectedSection = "أ";

  List<Map<String, String>> students = [
    {
      "name": "أحمد",
      "id": "111",
      "grade": "العاشر",
      "section": "أ"
    }
  ];

  List<String> get sections => school[selectedGrade]!;

  void addStudent() {
    if (nameController.text.isEmpty || idController.text.isEmpty) return;

    setState(() {
      students.add({
        "name": nameController.text,
        "id": idController.text,
        "grade": selectedGrade,
        "section": selectedSection,
      });

      nameController.clear();
      idController.clear();
    });
  }

  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  void editStudent(int index) {
    nameController.text = students[index]["name"]!;
    idController.text = students[index]["id"]!;
    selectedGrade = students[index]["grade"]!;
    selectedSection = students[index]["section"]!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Student"),
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                students[index] = {
                  "name": nameController.text,
                  "id": idController.text,
                  "grade": selectedGrade,
                  "section": selectedSection,
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
        title: const Text("Add Student"),
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              addStudent();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  List<Map<String, String>> get filteredStudents {
    return students.where((s) {
      return s["grade"] == selectedGrade &&
          s["section"] == selectedSection;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Students Management"),
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
                itemCount: filteredStudents.length,
                itemBuilder: (_, i) {
                  final s = filteredStudents[i];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading:
                      Icon(Icons.person, color: AppColors.primary),

                      title: Text(s["name"]!),

                      subtitle: Text(
                          "ID: ${s["id"]} | ${s["grade"]} - ${s["section"]}"),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.blue),
                            onPressed: () =>
                                editStudent(students.indexOf(s)),
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () =>
                                deleteStudent(students.indexOf(s)),
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