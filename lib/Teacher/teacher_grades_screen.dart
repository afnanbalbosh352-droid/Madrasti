import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class TeacherGradesScreen extends StatefulWidget {
  const TeacherGradesScreen({super.key});

  @override
  State<TeacherGradesScreen> createState() => _TeacherGradesScreenState();
}

class _TeacherGradesScreenState extends State<TeacherGradesScreen> {
  final gradeController = TextEditingController();

  // متغيرات الاختيار
  String selectedGrade = "Tenth";
  String selectedSection = "A";
  String? selectedStudent; // جعلناه null في البداية ليجبر المدرس على الاختيار
  String selectedSubject = "Math";
  String selectedExam = "First Exam";

  // القوائم
  final List<String> gradesList = ["Tenth", "Ninth", "Eighth"];
  final List<String> sections = ["A", "B", "C"];
  final List<String> subjects = ["Math", "Science", "English"];
  final List<String> exams = ["First Exam", "Second Exam", "Final Exam"];
  final List<String> students = ["Ahmed", "Muhammad", "Ali"];

  // القائمة التي تخزن العلامات قبل الإرسال النهائي
  List<Map<String, dynamic>> grades = [];

  void addOrUpdateGrade() {
    if (gradeController.text.isEmpty || selectedStudent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a student and enter a grade")),
      );
      return;
    }

    setState(() {
      // البحث إذا كان الطالب موجوداً مسبقاً لنفس المادة والامتحان لتعديله بدلاً من تكراره
      int existingIndex = grades.indexWhere((g) =>
          g["student"] == selectedStudent &&
          g["subject"] == selectedSubject &&
          g["exam"] == selectedExam);

      if (existingIndex != -1) {
        grades[existingIndex]["grade"] = gradeController.text;
      } else {
        grades.add({
          "student": selectedStudent,
          "class": "$selectedGrade $selectedSection",
          "subject": selectedSubject,
          "exam": selectedExam,
          "grade": gradeController.text,
        });
      }

      gradeController.clear();
      selectedStudent = null; // إعادة تعيين الاختيار لضمان عدم الخطأ
    });
  }

  void editGrade(int index) {
    setState(() {
      final item = grades[index];
      selectedStudent = item["student"];
      selectedSubject = item["subject"];
      selectedExam = item["exam"];
      gradeController.text = item["grade"];
      grades.removeAt(index); // حذفها مؤقتاً لحين إعادة إضافتها بعد التعديل
    });
  }

  void submitToAdmin() {
    // هنا يتم الربط مع Firebase لإرسال القائمة كاملة للأدمن
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Grades sent successfully for Admin approval!")),
    );
    setState(() {
      grades.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Adding Student's Grades")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 📦 نموذج الإدخال (Form)
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // الصف والشعبة في سطر واحد
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: selectedGrade,
                            decoration: const InputDecoration(labelText: "Grade"),
                            items: gradesList.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                            onChanged: (val) => setState(() => selectedGrade = val!),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: selectedSection,
                            decoration: const InputDecoration(labelText: "Section"),
                            items: sections.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                            onChanged: (val) => setState(() => selectedSection = val!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // اختيار الطالب
                    DropdownButtonFormField<String>(
                      initialValue: selectedStudent,
                      hint: const Text("Select Student"),
                      decoration: const InputDecoration(prefixIcon: Icon(Icons.person)),
                      items: students.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => selectedStudent = val!),
                    ),
                    const SizedBox(height: 10),

                    // المادة ونوع الامتحان
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: selectedSubject,
                            decoration: const InputDecoration(labelText: "Subject"),
                            items: subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                            onChanged: (val) => setState(() => selectedSubject = val!),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: selectedExam,
                            decoration: const InputDecoration(labelText: "Exam Type"),
                            items: exams.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (val) => setState(() => selectedExam = val!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // حقل العلامة وزر الإضافة
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: gradeController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: "Grade", hintText: "0-100"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: addOrUpdateGrade,
                            child: const Text("Add"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📋 عرض قائمة العلامات المضافة قبل الاعتماد
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("  Pending Grades:", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: grades.length,
                itemBuilder: (_, i) {
                  final g = grades[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text("${g["student"]} (${g["grade"]})"),
                      subtitle: Text("${g["subject"]} - ${g["exam"]}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => editGrade(i),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔘 زر الاعتماد النهائي
            if (grades.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: submitToAdmin,
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: const Text("Final Approval & Send", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}