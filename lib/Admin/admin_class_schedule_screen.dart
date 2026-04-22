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
  final List<String> subjects = ["Math", "Science", "English", "Arabic", "Religion"];
  final List<String> classes = ["C1", "C2", "C3", "C4", "C5", "C6"];

  String selectedGrade = "Grade 10";
  String selectedSection = "A";
  Map<String, List<String>> scheduleData = {};

  @override
  void initState() {
    super.initState();
    scheduleData = {for (var day in days) day: List.generate(classes.length, (_) => "-")};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Class Schedule Builder")),
      body: Column(
        children: [
          // اختيار الصف والشعبة
          Card(
            margin: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedGrade,
                    items: schoolStructure.keys.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (val) => setState(() => selectedGrade = val!),
                  ),
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedSection,
                    items: (schoolStructure[selectedGrade]!["sections"] as List<String>).map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (val) => setState(() => selectedSection = val!),
                  ),
                ),
              ],
            ),
          ),
          // الجدول
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  const DataColumn(label: Text("Class")),
                  ...days.map((d) => DataColumn(label: Text(d))),
                ],
                rows: List.generate(classes.length, (i) => DataRow(
                  cells: [
                    DataCell(Text(classes[i])),
                    ...days.map((day) => DataCell(
                      DropdownButton<String>(
                        value: scheduleData[day]![i],
                        items: ["-", ...subjects].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                        onChanged: (val) => setState(() => scheduleData[day]![i] = val!),
                      ),
                    )),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}