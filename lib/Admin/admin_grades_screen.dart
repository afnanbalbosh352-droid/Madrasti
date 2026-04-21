import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminGradesScreen extends StatefulWidget {
  const AdminGradesScreen({super.key});

  @override
  State<AdminGradesScreen> createState() =>
      _AdminGradesScreenState();
}

class _AdminGradesScreenState extends State<AdminGradesScreen> {

  final gradeController = TextEditingController();

  // 🎯 هيكل المدرسة
  final Map<String, Map<String, List<String>>> school = {
    "العاشر": {
      "أ": ["أحمد", "محمد"],
      "ب": ["علي", "سارة"],
    },
    "التاسع": {
      "أ": ["يوسف", "رامي"],
    }
  };

  String selectedGrade = "العاشر";
  String selectedSection = "أ";
  String? selectedStudent;

  String selectedSubject = "رياضيات";
  String selectedExam = "امتحان أول";

  final List<String> subjects = ["رياضيات", "علوم", "إنجليزي"];
  final List<String> exams = ["امتحان أول", "امتحان ثاني", "نهائي"];

  List<Map<String, dynamic>> grades = [
    {
      "student": "أحمد",
      "grade": "العاشر",
      "section": "أ",
      "subject": "رياضيات",
      "exam": "امتحان أول",
      "value": "85",
    }
  ];

  List<String> get sections =>
      school[selectedGrade]!.keys.toList();

  List<String> get students =>
      school[selectedGrade]![selectedSection]!;

  void updateGrade(int index) {
    gradeController.text = grades[index]["value"];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Grade"),
        content: TextField(
          controller: gradeController,
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                grades[index]["value"] = gradeController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  void deleteGrade(int index) {
    setState(() {
      grades.removeAt(index);
    });
  }

  List<Map<String, dynamic>> get filteredGrades {
    return grades.where((g) {
      return g["grade"] == selectedGrade &&
          g["section"] == selectedSection &&
          (selectedStudent == null ||
              g["student"] == selectedStudent) &&
          g["subject"] == selectedSubject &&
          g["exam"] == selectedExam;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Grades Control")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 📦 FILTER
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    // 🎓 الصف + الشعبة
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            initialValue: selectedGrade,
                            decoration:
                            const InputDecoration(labelText: "Grade"),
                            items: school.keys.map((g) {
                              return DropdownMenuItem(
                                  value: g, child: Text(g));
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedGrade = val!;
                                selectedSection =
                                    school[val]!.keys.first;
                                selectedStudent = null;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: DropdownButtonFormField(
                            initialValue: selectedSection,
                            decoration:
                            const InputDecoration(labelText: "Section"),
                            items: sections.map((s) {
                              return DropdownMenuItem(
                                  value: s, child: Text(s));
                            }).toList(),
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

                    // 👤 الطالب
                    DropdownButtonFormField(
                      initialValue: selectedStudent,
                      hint: const Text("Student (optional)"),
                      items: students.map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => selectedStudent = val),
                    ),

                    const SizedBox(height: 10),

                    // 📚 المادة + الامتحان
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            initialValue: selectedSubject,
                            decoration:
                            const InputDecoration(labelText: "Subject"),
                            items: subjects.map((s) {
                              return DropdownMenuItem(
                                  value: s, child: Text(s));
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => selectedSubject = val!),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: DropdownButtonFormField(
                            initialValue: selectedExam,
                            decoration:
                            const InputDecoration(labelText: "Exam"),
                            items: exams.map((e) {
                              return DropdownMenuItem(
                                  value: e, child: Text(e));
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => selectedExam = val!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 📋 LIST
            Expanded(
              child: ListView.builder(
                itemCount: filteredGrades.length,
                itemBuilder: (_, i) {
                  final g = filteredGrades[i];
                  final value = int.tryParse(g["value"]) ?? 0;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading:
                      Icon(Icons.grade, color: AppColors.primary),

                      title: Text(g["student"]),

                      subtitle: Text(
                          "${g["subject"]} (${g["exam"]})"),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Text(
                            g["value"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: value >= 90
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.blue),
                            onPressed: () =>
                                updateGrade(grades.indexOf(g)),
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () =>
                                deleteGrade(grades.indexOf(g)),
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