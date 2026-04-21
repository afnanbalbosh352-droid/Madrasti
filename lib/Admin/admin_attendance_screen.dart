import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminAttendanceScreen extends StatefulWidget {
  const AdminAttendanceScreen({super.key});

  @override
  State<AdminAttendanceScreen> createState() =>
      _AdminAttendanceScreenState();
}

class _AdminAttendanceScreenState
    extends State<AdminAttendanceScreen> {

  // 🎯 هيكل المدرسة
  final Map<String, Map<String, List<String>>> school = {
    "العاشر": {
      "أ": ["أحمد", "محمد", "علي"],
      "ب": ["سارة", "ليان"],
    },
    "التاسع": {
      "أ": ["يوسف", "رامي"],
    },
  };

  String selectedGrade = "العاشر";
  String selectedSection = "أ";

  DateTime selectedDate = DateTime.now();

  Map<String, String> attendance = {};

  List<String> get sections =>
      school[selectedGrade]!.keys.toList();

  List<String> get students =>
      school[selectedGrade]![selectedSection]!;

  void setAll(String value) {
    setState(() {
      for (var s in students) {
        attendance[s] = value;
      }
    });
  }

  void save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم حفظ التعديلات")),
    );
  }

  void pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Attendance Control")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 📦 FILTER CARD
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
                                attendance.clear();
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
                                attendance.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // 📅 التاريخ
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                          ),
                        ),
                        TextButton(
                          onPressed: pickDate,
                          child: const Text("Change"),
                        )
                      ],
                    ),

                    const SizedBox(height: 10),

                    // 🔘 Quick Actions
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => setAll("Present"),
                            child: const Text("All Present"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => setAll("Absent"),
                            child: const Text("All Absent"),
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
                itemCount: students.length,
                itemBuilder: (_, i) {
                  final s = students[i];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      title: Text(s),

                      trailing: DropdownButton<String>(
                        value: attendance[s],
                        hint: const Text("Status"),
                        items: ["Present", "Absent"].map((e) {
                          return DropdownMenuItem(
                              value: e, child: Text(e));
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            attendance[s] = val!;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            // 💾 SAVE
            ElevatedButton(
              onPressed: save,
              child: const Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}