import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class TeacherAssessmentScreen extends StatefulWidget {
  const TeacherAssessmentScreen({super.key});

  @override
  State<TeacherAssessmentScreen> createState() =>
      _TeacherAssessmentScreenState();
}

class _TeacherAssessmentScreenState extends State<TeacherAssessmentScreen> {

  final noteController = TextEditingController();

  // 🎯 هيكل المدرسة الحقيقي
  final Map<String, Map<String, List<String>>> school = {
    "العاشر": {
      "أ": ["أحمد", "محمد"],
      "ب": ["علي", "سارة"],
    },
    "التاسع": {
      "أ": ["ليان", "يوسف"],
    }
  };

  String selectedGrade = "العاشر";
  String selectedSection = "أ";
  String? selectedStudent;

  int selectedGradeValue = 80;

  List<Map<String, dynamic>> assessments = [];

  List<String> get sections => school[selectedGrade]!.keys.toList();

  List<String> get students =>
      school[selectedGrade]![selectedSection]!;

  void addAssessment() {
    if (selectedStudent == null || noteController.text.isEmpty) return;

    setState(() {
      assessments.add({
        "student": selectedStudent,
        "grade": selectedGrade,
        "section": selectedSection,
        "value": selectedGradeValue,
        "note": noteController.text,
      });

      noteController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("التقييم الشهري")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 📦 الفورم
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    // 🎓 الصف
                    DropdownButtonFormField<String>(
                      initialValue: selectedGrade,
                      decoration: const InputDecoration(labelText: "الصف"),
                      items: school.keys.map((g) {
                        return DropdownMenuItem(value: g, child: Text(g));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedGrade = val!;
                          selectedSection = school[val]!.keys.first;
                          selectedStudent = null;
                        });
                      },
                    ),

                    const SizedBox(height: 10),

                    // 🏫 الشعبة
                    DropdownButtonFormField<String>(
                      initialValue: selectedSection,
                      decoration: const InputDecoration(labelText: "الشعبة"),
                      items: sections.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedSection = val!;
                          selectedStudent = null;
                        });
                      },
                    ),

                    const SizedBox(height: 10),

                    // 👤 الطالب (ديناميك)
                    DropdownButtonFormField<String>(
                      initialValue: selectedStudent,
                      hint: const Text("اختر الطالب"),
                      items: students.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => selectedStudent = val),
                    ),

                    const SizedBox(height: 10),

                    // 📊 التقييم
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("التقييم: $selectedGradeValue"),
                        Slider(
                          value: selectedGradeValue.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 20,
                          onChanged: (val) {
                            setState(() {
                              selectedGradeValue = val.toInt();
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // 📝 ملاحظة
                    TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        labelText: "ملاحظة المعلم",
                      ),
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: addAssessment,
                      child: const Text("إضافة التقييم"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📋 عرض التقييمات
            Expanded(
              child: ListView.builder(
                itemCount: assessments.length,
                itemBuilder: (_, i) {
                  final a = assessments[i];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text("${a["student"]}"),
                      subtitle: Text(
                        "${a["grade"]} - ${a["section"]}\n${a["note"]}",
                      ),
                      trailing: Text(
                        "${a["value"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: a["value"] >= 90
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