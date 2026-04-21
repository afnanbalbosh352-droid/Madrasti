import 'package:flutter/material.dart';

class TeacherAssessmentScreen extends StatefulWidget {
  const TeacherAssessmentScreen({super.key});

  @override
  State<TeacherAssessmentScreen> createState() =>
      _TeacherAssessmentScreenState();
}

class _TeacherAssessmentScreenState extends State<TeacherAssessmentScreen> {
  final noteController = TextEditingController();

  // 🎯 English School Structure
  final Map<String, Map<String, List<String>>> school = {
    "Grade 10": {
      "A": ["Ahmad", "Mohammad"],
      "B": ["Ali", "Sarah"],
    },
    "Grade 9": {
      "A": ["Layan", "Yousef"],
    }
  };

  // 📊 Evaluation Levels
  final List<String> evaluationLevels = ["Excellent", "Very Good", "Good", "Poor"];

  String selectedGrade = "Grade 10";
  String selectedSection = "A";
  String? selectedStudent;
  String selectedEvaluation = "Good"; // Default Evaluation

  List<Map<String, dynamic>> assessments = [];

  List<String> get sections => school[selectedGrade]!.keys.toList();
  List<String> get students => school[selectedGrade]![selectedSection]!;

  void addAssessment() {
    if (selectedStudent == null || noteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a student and add a note")),
      );
      return;
    }

    setState(() {
      assessments.add({
        "student": selectedStudent,
        "grade": selectedGrade,
        "section": selectedSection,
        "evaluation": selectedEvaluation,
        "note": noteController.text,
      });

      noteController.clear();
      selectedStudent = null; // Reset selection after adding
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Monthly Assessment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 📦 Assessment Form Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Grade & Section Row
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedGrade,
                            decoration: const InputDecoration(labelText: "Grade"),
                            items: school.keys.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedGrade = val!;
                                selectedSection = school[val]!.keys.first;
                                selectedStudent = null;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedSection,
                            decoration: const InputDecoration(labelText: "Section"),
                            items: sections.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedSection = val!;
                                selectedStudent = null;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Student Selection
                    DropdownButtonFormField<String>(
                      value: selectedStudent,
                      hint: const Text("Select Student"),
                      decoration: const InputDecoration(icon: Icon(Icons.person)),
                      items: students.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => selectedStudent = val),
                    ),
                    const SizedBox(height: 10),

                    // ⭐ Evaluation Level Dropdown (Replaced Slider)
                    DropdownButtonFormField<String>(
                      value: selectedEvaluation,
                      decoration: const InputDecoration(
                        labelText: "Evaluation Rating",
                        icon: Icon(Icons.star_rate, color: Colors.amber),
                      ),
                      items: evaluationLevels.map((level) {
                        return DropdownMenuItem(value: level, child: Text(level));
                      }).toList(),
                      onChanged: (val) => setState(() => selectedEvaluation = val!),
                    ),
                    const SizedBox(height: 10),

                    // Teacher's Note
                    TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        labelText: "Teacher's Note",
                        hintText: "Enter comments here...",
                        prefixIcon: Icon(Icons.note_alt),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Add Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: addAssessment,
                        icon: const Icon(Icons.add),
                        label: const Text("Add Assessment"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Recent Assessments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),

            // 📋 List of Assessments
            Expanded(
              child: ListView.builder(
                itemCount: assessments.length,
                itemBuilder: (_, i) {
                  final a = assessments[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text("${a["student"]} (${a["evaluation"]})"),
                      subtitle: Text("Grade: ${a["grade"]} | Section: ${a["section"]}\nNote: ${a["note"]}"),
                      isThreeLine: true,
                      trailing: Icon(
                        Icons.check_circle,
                        color: a["evaluation"] == "Excellent" ? Colors.green : Colors.blue,
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