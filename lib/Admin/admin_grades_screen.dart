import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminGradesScreen extends StatefulWidget {
  const AdminGradesScreen({super.key});

  @override
  State<AdminGradesScreen> createState() => _AdminGradesApprovalScreenState();
}

class _AdminGradesApprovalScreenState extends State<AdminGradesScreen> {
  String selectedGrade = "Tenth";
  String selectedSection = "A";
  String selectedSemester = "Current Semester";

  // بيانات الطلاب مع كشف كامل للعلامات
  final List<Map<String, dynamic>> studentsGrades = [
    {
      "name": "Ahmed Mohamed",
      "subject": "Mathematics",
      "first": 18,
      "second": 19,
      "mid": 25,
      "participation": 10,
      "total": 72,
      "isApproved": false,
    },
    {
      "name": "Sami Ali",
      "subject": "Mathematics",
      "first": 15,
      "second": 14,
      "mid": 20,
      "participation": 8,
      "total": 57,
      "isApproved": true,
    },
  ];

  // دالة لإظهار معاينة الشهادة (Report Card Pop-up)
  void _showReportCardPreview(String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report Card Preview"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
            const SizedBox(height: 10),
            Text("Generating official report card for $name..."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Download PDF"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Final Grades Approval"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // قسم الفلترة
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedSemester,
                      decoration: const InputDecoration(labelText: "Academic Period", prefixIcon: Icon(Icons.history)),
                      items: ["Current Semester", "Previous Semester"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => selectedSemester = val!),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedGrade,
                            decoration: const InputDecoration(labelText: "Grade"),
                            items: ["Tenth", "Ninth"].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                            onChanged: (val) => setState(() => selectedGrade = val!),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedSection,
                            decoration: const InputDecoration(labelText: "Section"),
                            items: ["A", "B"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                            onChanged: (val) => setState(() => selectedSection = val!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // قائمة عرض كشوفات العلامات
            Expanded(
              child: ListView.builder(
                itemCount: studentsGrades.length,
                itemBuilder: (context, index) {
                  final student = studentsGrades[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(student["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Icon(
                                student["isApproved"] ? Icons.check_circle : Icons.pending,
                                color: student["isApproved"] ? Colors.green : Colors.orange,
                              ),
                            ],
                          ),
                          Text(student["subject"], style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          const Divider(),
                          // عرض تفاصيل العلامات الأربعة + المجموع
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildGradeBox("1st", student["first"]),
                              _buildGradeBox("2nd", student["second"]),
                              _buildGradeBox("Mid", student["mid"]),
                              _buildGradeBox("Part.", student["participation"]),
                              _buildGradeBox("Total", student["total"], isFinal: true),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // أزرار المدير
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (!student["isApproved"])
                                ElevatedButton.icon(
                                  onPressed: () => setState(() => student["isApproved"] = true),
                                  icon: const Icon(Icons.done_all, size: 18, color: Colors.white),
                                  label: const Text("Approve", style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                )
                              else
                                OutlinedButton.icon(
                                  onPressed: () => _showReportCardPreview(student["name"]),
                                  icon: const Icon(Icons.picture_as_pdf, size: 18),
                                  label: const Text("View Report Card"),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // زر الاعتماد الكلي لطباعة كل شهادات الصف
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.print_rounded),
                label: const Text("Print All Approved Certificates"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ودجت صغيرة لعرض كل علامة في صندوق
  Widget _buildGradeBox(String label, dynamic value, {bool isFinal = false}) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isFinal ? AppColors.primary.withOpacity(0.1) : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.toString(),
            style: TextStyle(
              fontWeight: isFinal ? FontWeight.bold : FontWeight.normal,
              color: isFinal ? AppColors.primary : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}