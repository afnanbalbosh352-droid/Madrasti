import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class TeacherScheduleScreen extends StatefulWidget {
  const TeacherScheduleScreen({super.key});

  @override
  State<TeacherScheduleScreen> createState() => _TeacherScheduleScreenState();
}

class _TeacherScheduleScreenState extends State<TeacherScheduleScreen> {
  // 🎯 هيكل البيانات (تم التأكد من وجود العاشر والسابع)
  final Map<String, Map<String, Map<String, List<String>>>> schedule = {
    "Tenth": {
      "A": {
        "Sunday": ["Math", "Science", "English", "Arabic", "Math", "Science", "Art"],
        "Monday": ["Science", "Math", "Arabic", "English", "Math", "Religion", "Computer"],
      },
      "B": {
        "Sunday": ["Arabic", "Math", "Science", "English", "Math", "Art", "Arabic"],
        "Monday": ["English", "Science", "Math", "Arabic", "Math", "Religion", "Art"],
      },
    },
    "Seventh": {
      "A": {
        "Sunday": ["Math", "Arabic", "Science", "English", "Math", "Art", "Computer"],
        "Monday": ["Arabic", "Math", "English", "Science", "Religion", "Math", "Art"],
      },
      "B": {
        "Sunday": ["Science", "Math", "Arabic", "English", "Math", "Art", "Religion"],
        "Monday": ["Math", "Science", "English", "Arabic", "Math", "Computer", "Art"],
      },
    },
  };

  String selectedGrade = "Tenth";
  String selectedSection = "A";

  final List<String> days = ["Sunday", "Monday"];
  final List<String> periods = [
    "Class 1", "Class 2", "Class 3", "Class 4",
    "Class 5", "Class 6", "Class 7", 
  ];

  // دالة لجلب الشعب المتاحة للصف المختار
  List<String> get sections => schedule[selectedGrade]!.keys.toList();

  @override
  Widget build(BuildContext context) {
    // جلب البيانات الحالية بناءً على الاختيار
    final current = schedule[selectedGrade]![selectedSection]!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Teacher Schedule"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 📦 صندوق اختيار الصف والشعبة
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // قائمة اختيار الصف (عاشر / سابع)
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedGrade, // استخدام value بدلاً من initialValue للإصلاح
                        decoration: const InputDecoration(labelText: "Grade"),
                        items: schedule.keys.map((g) {
                          return DropdownMenuItem(value: g, child: Text(g));
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedGrade = val!;
                            // تحديث الشعبة تلقائياً لتجنب تعارض البيانات
                            selectedSection = schedule[val]!.keys.first;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    // قائمة اختيار الشعبة
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedSection, // استخدام value بدلاً من initialValue للإصلاح
                        decoration: const InputDecoration(labelText: "Section"),
                        items: sections.map((s) {
                          return DropdownMenuItem(value: s, child: Text(s));
                        }).toList(),
                        onChanged: (val) {
                          setState(() => selectedSection = val!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📊 جدول الحصص
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(
                        AppColors.primary.withOpacity(0.1),
                      ),
                      columns: [
                        const DataColumn(label: Text("Class", style: TextStyle(fontWeight: FontWeight.bold))),
                        ...days.map((d) => DataColumn(label: Text(d, style: const TextStyle(fontWeight: FontWeight.bold)))),
                      ],
                      rows: List.generate(periods.length, (i) {
                        return DataRow(
                          cells: [
                            DataCell(Text(periods[i], style: const TextStyle(fontWeight: FontWeight.w500))),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}