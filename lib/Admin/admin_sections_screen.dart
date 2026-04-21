import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminSectionsScreen extends StatefulWidget {
  const AdminSectionsScreen({super.key});

  @override
  State<AdminSectionsScreen> createState() =>
      _AdminSectionsScreenState();
}

class _AdminSectionsScreenState extends State<AdminSectionsScreen> {

  final controller = TextEditingController();

  // 🎯 الصفوف + الشعب
  final Map<String, List<String>> school = {
    "العاشر": ["أ", "ب"],
    "التاسع": ["أ"],
  };

  String selectedGrade = "العاشر";

  List<String> get sections => school[selectedGrade]!;

  void addSection() {
    if (controller.text.isEmpty) return;

    setState(() {
      school[selectedGrade]!.add(controller.text);
      controller.clear();
    });
  }

  void deleteSection(int index) {
    setState(() {
      school[selectedGrade]!.removeAt(index);
    });
  }

  void editSection(int index) {
    controller.text = sections[index];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Section"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                school[selectedGrade]![index] = controller.text;
                controller.clear();
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
        title: const Text("Add Section"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Section name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addSection();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Sections Management"),
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

            // 🎓 اختيار الصف
            DropdownButtonFormField(
              initialValue: selectedGrade,
              decoration: const InputDecoration(labelText: "Select Class"),
              items: school.keys.map((g) {
                return DropdownMenuItem(value: g, child: Text(g));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedGrade = val!;
                });
              },
            ),

            const SizedBox(height: 15),

            // 📋 الشعب
            Expanded(
              child: ListView.builder(
                itemCount: sections.length,
                itemBuilder: (_, i) {
                  final s = sections[i];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading:
                      Icon(Icons.group, color: AppColors.primary),

                      title: Text("Section $s"),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.blue),
                            onPressed: () => editSection(i),
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
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