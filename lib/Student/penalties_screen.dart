import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class PenaltiesScreen extends StatelessWidget {
  const PenaltiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Warnings & Penalties", style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.gradient),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ⚠️ التحذير الأول: إزعاج في الحصة
          _buildPenaltyCard(
            title: "Class Disturbance",
            arabicTitle: "إزعاج داخل الحصة",
            date: "2024-04-15",
            reason: "The student was warned for causing a disturbance and talking during the lesson, which affected the flow of the class.",
            arabicReason: "تم تنبيه الطالب بسبب إحداث إزعاج والكلام أثناء الشرح، مما أثر على سير الحصة الدراسية.",
            penaltyType: "Verbal Warning",
            isSerious: false,
          ),
          
          const SizedBox(height: 10),

          // ⚠️ التحذير الثاني: مشكلة مع الزملاء
          _buildPenaltyCard(
            title: "Peer Conflict",
            arabicTitle: "مشكلة مع الزملاء",
            date: "2024-04-10",
            reason: "The student was involved in a verbal altercation and created a problem with their classmates in the school yard.",
            arabicReason: "تورط الطالب في مشادة كلامية وافتعال مشكلة مع زملائه في ساحة المدرسة.",
            penaltyType: "Written Warning",
            isSerious: true, // جعلناه باللون الأحمر لأنه تصرف هجومي
          ),
        ],
      ),
    );
  }

  // دالة بناء كرت التحذير المطور
  Widget _buildPenaltyCard({
    required String title,
    required String arabicTitle,
    required String date,
    required String reason,
    required String arabicReason,
    required String penaltyType,
    required bool isSerious,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: isSerious ? Colors.red : Colors.orange, width: 6),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                    Text(arabicTitle, style: const TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                ),
                Icon(Icons.warning_amber_rounded, color: isSerious ? Colors.red : Colors.orange, size: 30),
              ],
            ),
            const Divider(height: 20),
            Text("Date: $date", style: const TextStyle(color: Colors.blueGrey, fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            const Text("Reason / السبب:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 5),
            Text(reason, style: const TextStyle(color: Colors.black87, fontSize: 14)),
            const SizedBox(height: 4),
            Text(arabicReason, textDirection: TextDirection.rtl, style: const TextStyle(color: Colors.black54, fontSize: 14)),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text("Action / الإجراء: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSerious ? Colors.red.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    penaltyType,
                    style: TextStyle(color: isSerious ? Colors.red : Colors.orange, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}