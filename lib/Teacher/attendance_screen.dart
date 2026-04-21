import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  // 🎯 اختيار الصف والشعبة
  String selectedGrade = "العاشر";
  String selectedSection = "أ";

  final List<String> grades = ["العاشر", "التاسع"];
  final List<String> sections = ["أ", "ب"];

  // 👨‍🎓 طلاب (Fake)
  final List<String> students = ["أحمد", "محمد", "علي"];

  final Map<String, String> status = {};
  bool submitted = false;

  // ✅ تسجيل الكل حضور
  void markAllPresent() {
    setState(() {
      for (var s in students) {
        status[s] = "حضور";
      }
    });
  }

  // ❌ تسجيل الكل غياب
  void markAllAbsent() {
    setState(() {
      for (var s in students) {
        status[s] = "غياب";
      }
    });
  }

  void submit() {
    setState(() => submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("تسجيل الحضور")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 📦 اختيار الصف والشعبة
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [

                    Expanded(
                      child: DropdownButtonFormField(
                        initialValue: selectedGrade,
                        decoration: const InputDecoration(labelText: "الصف"),
                        items: grades.map((g) {
                          return DropdownMenuItem(value: g, child: Text(g));
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => selectedGrade = val!),
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

            // 🔘 أزرار جماعية
            if (!submitted)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: markAllPresent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text("الكل حضور"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: markAllAbsent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("الكل غياب"),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 10),

            // 📋 قائمة الطلاب
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (_, i) {
                  final s = students[i];
                  final current = status[s];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(s),

                      trailing: submitted
                          ? Text(
                        current ?? "-",
                        style: TextStyle(
                          color: current == "حضور"
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          // حضور
                          IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: current == "حضور"
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                status[s] = "حضور";
                              });
                            },
                          ),

                          // غياب
                          IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: current == "غياب"
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                status[s] = "غياب";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔘 زر الإرسال
            if (!submitted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit,
                  child: const Text("تأكيد الحضور"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}