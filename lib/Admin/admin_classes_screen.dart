import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminClassesScreen extends StatefulWidget {
  const AdminClassesScreen({super.key});

  @override
  State<AdminClassesScreen> createState() =>
      _AdminClassesScreenState();
}

class _AdminClassesScreenState extends State<AdminClassesScreen> {

  final controller = TextEditingController();

  List<String> classes = [
    "العاشر",
    "التاسع",
    "الثامن",
  ];

  void addClass() {
    if (controller.text.isEmpty) return;

    setState(() {
      classes.add(controller.text);
      controller.clear();
    });
  }

  void deleteClass(int index) {
    setState(() {
      classes.removeAt(index);
    });
  }

  void editClass(int index) {
    controller.text = classes[index];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Class"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                classes[index] = controller.text;
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
        title: const Text("Add Class"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Class name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addClass();
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
        title: const Text("Classes Management"),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        itemBuilder: (_, i) {
          final c = classes[i];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: Icon(Icons.class_, color: AppColors.primary),

              title: Text(c),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => editClass(i),
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteClass(i),
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