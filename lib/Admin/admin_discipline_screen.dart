import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminPenaltiesScreen extends StatefulWidget {
  const AdminPenaltiesScreen({super.key});

  @override
  State<AdminPenaltiesScreen> createState() => _AdminPenaltiesScreenState();
}

class _AdminPenaltiesScreenState extends State<AdminPenaltiesScreen> {
  final _reasonController = TextEditingController();
  
  // قيم الفلترة والاختيار
  String selectedGrade = "Tenth";
  String selectedSection = "A";
  String? selectedStudent; 
  String selectedType = "Warning (تنبيه)"; 

  final List<String> penaltyTypes = [
    "Warning (تنبيه)",
    "Final Warning (إنذار نهائي)",
    "Suspension (فصل مؤقت)",
    "Transfer (نقل من الصف)"
  ];

  // بيانات تجريبية للسجل (History)
  final List<Map<String, String>> penaltyHistory = [
    {"student": "Ahmed Mohamed", "type": "Warning", "date": "2026-04-20"},
    {"student": "Sami Ali", "type": "Final Warning", "date": "2026-04-18"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Penalties"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Issue New Penalty",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            
            // كرت الإدخال
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // صف اختيار الصف والشعبة
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: selectedGrade,
                            decoration: const InputDecoration(labelText: "Grade", border: UnderlineInputBorder()),
                            items: ["Tenth", "Ninth", "Eighth"].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                            onChanged: (val) => setState(() => selectedGrade = val!),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: selectedSection,
                            decoration: const InputDecoration(labelText: "Section", border: UnderlineInputBorder()),
                            items: ["A", "B", "C"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                            onChanged: (val) => setState(() => selectedSection = val!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // اختيار اسم الطالب
                    DropdownButtonFormField<String>(
                      initialValue: selectedStudent,
                      hint: const Text("Select Student Name"),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      items: ["Ahmed Mohamed", "Sami Ali", "Laila Hassan"].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => selectedStudent = val),
                    ),
                    const SizedBox(height: 20),

                    // اختيار نوع العقوبة
                    DropdownButtonFormField<String>(
                      initialValue: selectedType,
                      decoration: const InputDecoration(
                        labelText: "Penalty Type",
                        prefixIcon: Icon(Icons.gavel_outlined),
                        border: OutlineInputBorder(),
                      ),
                      items: penaltyTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                      onChanged: (val) => setState(() => selectedType = val!),
                    ),
                    const SizedBox(height: 20),

                    // تفاصيل السبب
                    TextField(
                      controller: _reasonController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Reason",
                        hintText: "Why is this penalty being issued?",
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // زر الإرسال
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitPenalty,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Submit Penalty", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              "Recent Penalties History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // قائمة السجل (History)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: penaltyHistory.length,
              itemBuilder: (context, index) {
                final item = penaltyHistory[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: Icon(Icons.history, color: Colors.white),
                    ),
                    title: Text(item["student"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${item["type"]} - ${item["date"]}"),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitPenalty() {
    if (selectedStudent == null || _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields!")),
      );
      return;
    }
    
    // محاكاة إضافة للسجل
    setState(() {
      penaltyHistory.insert(0, {
        "student": selectedStudent!,
        "type": selectedType,
        "date": DateTime.now().toString().split(' ')[0],
      });
      selectedStudent = null;
      _reasonController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Penalty Submitted Successfully!")),
    );
  }
}