import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class TeacherGradesScreen extends StatefulWidget {
  const TeacherGradesScreen({super.key});

  @override
  State<TeacherGradesScreen> createState() => _TeacherGradesScreenState();
}

class _TeacherGradesScreenState extends State<TeacherGradesScreen> {

  final gradeController = TextEditingController();

 String selectedStudent = "Ahmed";
String selectedClass = "Tenth A";
String selectedSubject = "Math";
String selectedExam = "First Exam";

final List<String> students = ["Ahmed", "Muhammad", "Ali"];
final List<String> classes = ["Tenth A", "Tenth B"];
final List<String> subjects = ["Math", "Science", "English"];
final List<String> exams = ["First Exam", "Second Exam", "Final Exam"];

  List<Map<String, dynamic>> grades = [];

  void addGrade() {
    if (gradeController.text.isEmpty) return;

    setState(() {
      grades.add({
        "student": selectedStudent,
        "class": selectedClass,
        "subject": selectedSubject,
        "exam": selectedExam,
        "grade": gradeController.text,
      });

      gradeController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Adding student's grades")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 📦 Form
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    // 👤 الطالب
                    DropdownButtonFormField<String>(
                      initialValue: selectedStudent,
                      decoration: const InputDecoration(labelText: "Student"),
                      items: students.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => selectedStudent = val!),
                    ),

                    const SizedBox(height: 10),

                    // 🏫 الصف
                    DropdownButtonFormField<String>(
                      initialValue: selectedClass,
                      decoration: const InputDecoration(labelText: "Class"),
                      items: classes.map((c) {
                        return DropdownMenuItem(value: c, child: Text(c));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => selectedClass = val!),
                    ),

                    const SizedBox(height: 10),

                    // 📚 المادة
                    DropdownButtonFormField<String>(
                      initialValue: selectedSubject,
                      decoration: const InputDecoration(labelText: "Subject"),
                      items: subjects.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => selectedSubject = val!),
                    ),

                    const SizedBox(height: 10),

                    // 🧾 نوع الامتحان
                    DropdownButtonFormField<String>(
                      initialValue: selectedExam,
                      decoration: const InputDecoration(labelText: "Exam type"),
                      items: exams.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => selectedExam = val!),
                    ),

                    const SizedBox(height: 10),

                    // 📊 العلامة
                    TextField(
                      controller: gradeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Grade",
                      ),
                    ),

                    const SizedBox(height: 15),

                    // 🔘 زر
                    ElevatedButton(
                      onPressed: addGrade,
                      child: const Text("Add grade"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📋 عرض العلامات
            Expanded(
              child: ListView.builder(
                itemCount: grades.length,
                itemBuilder: (_, i) {
                  final g = grades[i];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                          "${g["student"]} - ${g["subject"]} (${g["exam"]})"),
                      subtitle: Text("Class: ${g["class"]}"),
                      trailing: Text(
                        g["grade"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: int.parse(g["grade"]) >= 90
                              ? Colors.green
                              : Colors.orange,
                        ),
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