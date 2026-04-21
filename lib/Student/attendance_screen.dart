import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Logic Section ---
    const int totalSemesterDays = 100;
    const double allowedPercentage = 0.10;
    int maxAllowedDays = (totalSemesterDays * allowedPercentage).toInt();
    int absentDays = 9;
    int remainingDays = maxAllowedDays - absentDays;
    double progress = absentDays / maxAllowedDays;
    bool isAtRisk = absentDays >= 9;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Attendance Tracker"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Total Semester Days: $totalSemesterDays",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isAtRisk ? "Warning: High Absence!" : "Your Attendance is Good",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 2. Central Gauge Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                              value: progress > 1.0 ? 1.0 : progress,
                              strokeWidth: 12,
                              backgroundColor: Colors.grey.shade200,
                              color: isAtRisk ? Colors.redAccent : Colors.green,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "$absentDays / $maxAllowedDays",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: isAtRisk ? Colors.red : Colors.black87,
                                ),
                              ),
                              const Text("Days Absent", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatDetail("Remaining", "$remainingDays", Colors.blue),
                          _buildStatDetail("Limit", "$maxAllowedDays Days", Colors.orange),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. Risk Warning Section
            if (isAtRisk)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.red),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "Warning: You have reached the allowed absence limit. Please be careful.",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ], // children 
        ), // colomn
      ), // SingleChildScrollView
    ); // Scaffold
  } //  build

  // الدالة المساعدة
  Widget _buildStatDetail(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}