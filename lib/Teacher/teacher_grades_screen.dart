import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class TeacherGradesScreen extends StatefulWidget {
  const TeacherGradesScreen({super.key});

  @override
  State<TeacherGradesScreen> createState() => _TeacherGradesScreenState();
}

class _TeacherGradesScreenState extends State<TeacherGradesScreen> {

  final gradeController = TextEditingController();

  String selectedStudent = "أحمد";
  String selectedClass = "العاشر أ";
  String selectedSubject = "رياضيات";
  String selectedExam = "امتحان أول";

  final List<String> students = ["أحمد", "محمد", "علي"];
  final List<String> classes = ["العاشر أ", "العاشر ب"];
  final List<String> subjects = ["رياضيات", "علوم", "إنجليزي"];
  final List<String> exams = ["امتحان أول", "امتحان ثاني", "نهائي"];

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
      appBar: AppBar(title: const Text("إدخال العلامات")),

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
                      decoration: const InputDecoration(labelText: "الطالب"),
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
                      decoration: const InputDecoration(labelText: "الصف"),
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
                      decoration: const InputDecoration(labelText: "المادة"),
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
                      decoration: const InputDecoration(labelText: "نوع الامتحان"),
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
                        labelText: "العلامة",
                      ),
                    ),

                    const SizedBox(height: 15),

                    // 🔘 زر
                    ElevatedButton(
                      onPressed: addGrade,
                      child: const Text("إضافة العلامة"),
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
                      subtitle: Text("الصف: ${g["class"]}"),
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