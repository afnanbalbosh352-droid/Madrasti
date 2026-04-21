import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({super.key});

  @override
  State<AdminScheduleScreen> createState() =>
      _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen> {

  // 🎯 هيكل المدرسة
  final Map<String, Map<String, dynamic>> school = {
    "العاشر": {"sections": ["أ", "ب"]},
    "التاسع": {"sections": ["أ"]},
  };

  final List<String> days = [
    "الأحد",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس"
  ];

  final List<String> subjects = [
    "رياضيات",
    "علوم",
    "إنجليزي",
    "عربي",
    "دين",
    "رياضة"
  ];

  final List<String> periods = [
    "حصة 1",
    "حصة 2",
    "حصة 3",
    "حصة 4",
    "حصة 5",
    "حصة 6",
    "حصة 7",
    "حصة 8",
  ];

  String selectedGrade = "العاشر";
  String selectedSection = "أ";

  // 🧠 الجدول
  Map<String, List<String>> schedule = {};

  @override
  void initState() {
    super.initState();
    initSchedule();
  }

  void initSchedule() {
    schedule = {
      for (var day in days) day: List.generate(8, (_) => "-")
    };
  }

  void saveSchedule() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Schedule Saved Successfully")),
    );
  }

  List<String> get sections =>
      school[selectedGrade]!["sections"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Schedule Builder")),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            // 📦 اختيار الصف والشعبة
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
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
                            selectedSection =
                            school[val]!["sections"][0];
                            initSchedule();
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
                        onChanged: (val) {
                          setState(() {
                            selectedSection = val!;
                            initSchedule();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 📊 جدول قابل للتعديل
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20,
                  headingRowColor: WidgetStateProperty.all(
                    AppColors.primary.withOpacity(0.1),
                  ),
                  columns: [
                    const DataColumn(label: Text("الحصة")),
                    ...days.map((d) => DataColumn(label: Text(d))),
                  ],
                  rows: List.generate(periods.length, (i) {
                    return DataRow(
                      cells: [
                        DataCell(Text(periods[i])),

                        ...days.map((day) {
                          return DataCell(
                            DropdownButton<String>(
                              value: schedule[day]![i],
                              items: [
                                const DropdownMenuItem<String>(
                                  value: "-",
                                  child: Text("-"),
                                ),
                                ...subjects.map((s) => DropdownMenuItem<String>(
                                  value: s,
                                  child: Text(s),
                                ))
                              ],
                              onChanged: (val) {
                                setState(() {
                                  schedule[day]![i] = val!;
                                });
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 💾 حفظ
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveSchedule,
                child: const Text("Save Schedule"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}