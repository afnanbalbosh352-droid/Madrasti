import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminClassScheduleScreen extends StatefulWidget {
  const AdminClassScheduleScreen({super.key});

  @override
  State<AdminClassScheduleScreen> createState() => _AdminClassScheduleScreenState();
}

class _AdminClassScheduleScreenState extends State<AdminClassScheduleScreen> {
  final Map<String, Map<String, dynamic>> schoolStructure = {
    "Grade 10": {"sections": ["A", "B"]},
    "Grade 9": {"sections": ["A"]},
  };

  final List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu"];
  final List<String> subjects = ["-", "Math", "Science", "English", "Arabic", "Religion"];
  final List<String> periods = ["C1", "C2", "C3", "C4", "C5", "C6"];

  String selectedGrade = "Grade 10";
  String selectedSection = "A";
  
  // تعريف هيكل البيانات للجدول
  Map<String, List<String>> scheduleData = {};

  @override
  void initState() {
    super.initState();
    _initializeSchedule();
  }

  void _initializeSchedule() {
    // بناء جدول فارغ مبدئياً
    scheduleData = {
      for (var day in days) day: List.generate(periods.length, (_) => "-")
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Class Schedule Builder"),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          // 🔵 اختيار الصف والشعبة
          Card(
            margin: const EdgeInsets.all(12),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: "Grade"),
                      initialValue: selectedGrade,
                      items: schoolStructure.keys.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedGrade = val!;
                          // 🔥 صمام أمان: تحديث الشعبة لتكون دائماً موجودة في الصف الجديد
                          List<String> availableSections = List<String>.from(schoolStructure[selectedGrade]!["sections"]);
                          selectedSection = availableSections.first;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: "Section"),
                      initialValue: selectedSection,
                      items: (schoolStructure[selectedGrade]!["sections"] as List<String>)
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (val) => setState(() => selectedSection = val!),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📅 الجدول التفاعلي
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    border: TableBorder.all(color: Colors.grey.shade300, width: 1),
                    columnSpacing: 25,
                    headingRowColor: WidgetStateProperty.all(Colors.blue.shade50),
                    columns: [
                      const DataColumn(label: Text("Period", style: TextStyle(fontWeight: FontWeight.bold))),
                      ...days.map((d) => DataColumn(label: Text(d, style: const TextStyle(fontWeight: FontWeight.bold)))),
                    ],
                    rows: List.generate(periods.length, (rowIdx) => DataRow(
                      cells: [
                        DataCell(Text(periods[rowIdx], style: const TextStyle(fontWeight: FontWeight.bold))),
                        ...days.map((day) => DataCell(
                          DropdownButton<String>(
                            value: scheduleData[day]![rowIdx],
                            underline: const SizedBox(),
                            icon: const Icon(Icons.arrow_drop_down, size: 18),
                            items: subjects.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 13)))).toList(),
                            onChanged: (val) {
                              setState(() {
                                scheduleData[day]![rowIdx] = val!;
                              });
                            },
                          ),
                        )),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}