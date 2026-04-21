import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class TeacherScheduleScreen extends StatefulWidget {
  const TeacherScheduleScreen({super.key});

  @override
  State<TeacherScheduleScreen> createState() =>
      _TeacherScheduleScreenState();
}

class _TeacherScheduleScreenState extends State<TeacherScheduleScreen> {

  // 🎯 هيكل المدرسة (يوم + حصة)
  final Map<String, Map<String, Map<String, List<String>>>> schedule = {
    "العاشر": {
      "أ": {
        "الأحد": [
          "رياضيات", "علوم", "إنجليزي", "عربي",
          "رياضيات", "علوم", "رياضة", "فن"
        ],
        "الإثنين": [
          "علوم", "رياضيات", "عربي", "إنجليزي",
          "رياضيات", "دين", "حاسوب", "رياضة"
        ],
      },
      "ب": {
        "الأحد": [
          "عربي", "رياضيات", "علوم", "إنجليزي",
          "رياضيات", "رياضة", "فن", "دين"
        ],
      },
    },
  };

  String selectedGrade = "العاشر";
  String selectedSection = "أ";

  final List<String> days = ["الأحد", "الإثنين"];
  final List<String> periods = [
    "الحصة 1",
    "الحصة 2",
    "الحصة 3",
    "الحصة 4",
    "الحصة 5",
    "الحصة 6",
    "الحصة 7",
    "الحصة 8",
  ];

  List<String> get sections =>
      schedule[selectedGrade]!.keys.toList();

  @override
  Widget build(BuildContext context) {
    final current = schedule[selectedGrade]![selectedSection]!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("جدول الحصص")),

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
                        decoration: const InputDecoration(labelText: "الصف"),
                        items: schedule.keys.map((g) {
                          return DropdownMenuItem(value: g, child: Text(g));
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedGrade = val!;
                            selectedSection =
                                schedule[val]!.keys.first;
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: DropdownButtonFormField(
                        initialValue: selectedSection,
                        decoration: const InputDecoration(labelText: "الشعبة"),
                        items: sections.map((s) {
                          return DropdownMenuItem(value: s, child: Text(s));
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => selectedSection = val!),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 📊 جدول حقيقي
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
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
                          final subject = current[day]?[i] ?? "-";
                          return DataCell(Text(subject));
                        }),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}