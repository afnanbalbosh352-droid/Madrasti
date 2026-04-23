import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AdminAddExamScreen extends StatefulWidget {
  const AdminAddExamScreen({super.key});

  @override
  State<AdminAddExamScreen> createState() => _AdminAddExamScreenState();
}

class _AdminAddExamScreenState extends State<AdminAddExamScreen> {
  String? selectedGrade;
  String? selectedSection;
  String? selectedSubject;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final List<String> grades = ['8th', '9th', '10th', '11th', '12th'];
  final List<String> sections = ['A', 'B', 'C'];
  final List<String> subjects = ['Mathematics', 'Physics', 'Chemistry', 'English', 'Arabic', 'Biology'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Register New Exam", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppColors.gradient)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Exam Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const SizedBox(height: 20),
            
            // اختيار المادة
            _buildDropdown("Select Subject", subjects, selectedSubject, (val) => setState(() => selectedSubject = val)),
            
            // اختيار الصف والشعبة في سطر واحد
            Row(
              children: [
                Expanded(child: _buildDropdown("Grade", grades, selectedGrade, (val) => setState(() => selectedGrade = val))),
                const SizedBox(width: 15),
                Expanded(child: _buildDropdown("Section", sections, selectedSection, (val) => setState(() => selectedSection = val))),
              ],
            ),

            const SizedBox(height: 20),
            const Text("Date & Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // زر اختيار التاريخ
            _buildPickerTile(
              icon: Icons.calendar_month,
              label: selectedDate == null ? "Pick Date" : "${selectedDate!.toLocal()}".split(' ')[0],
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                );
                if (picked != null) setState(() => selectedDate = picked);
              },
            ),

            // زر اختيار الوقت
            _buildPickerTile(
              icon: Icons.access_time,
              label: selectedTime == null ? "Pick Time" : selectedTime!.format(context),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                if (picked != null) setState(() => selectedTime = picked);
              },
            ),

            const SizedBox(height: 40),

            // زر الحفظ النهائي
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  // هنا نضع كود الحفظ (مثلاً إظهار رسالة نجاح)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Exam Registered Successfully!"), backgroundColor: Colors.green),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Save Exam", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجت مساعدة لبناء القوائم المنسدلة
  Widget _buildDropdown(String hint, List<String> items, String? value, Function(String?) onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint),
          value: value,
          isExpanded: true,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildPickerTile({required IconData icon, required String label, required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
    );
  }
}