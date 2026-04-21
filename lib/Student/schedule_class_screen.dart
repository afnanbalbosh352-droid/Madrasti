import 'package:flutter/material.dart';
import '../General/app_colors.dart';

class ScheduleClassScreen extends StatelessWidget {
   ScheduleClassScreen({super.key});

  // ❌ لا تستخدم const هنا
  final List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday"
  ];

  final List<String> times = [
    "8-9",
    "9-10",
    "10-11",
    "11-12",
    "12-1"
  ];

  final Map<String, String> schedule = {
    "Sunday_8-9": "Maths",
    "Sunday_9-10": "Arabic",
    "Sunday_10-11": "English",
    "Sunday_11-12": "Science",
     "Sunday_12-1": "Computer",
    "Monday_8-9": "Science",
    "Tuesday_10-11": "English",
    "Wednesday_11-12": "Computer",
    "Thursday_12-1": "Sports",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class Schedule"),
      ),
      backgroundColor: AppColors.background,

      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              AppColors.primary.withOpacity(0.1),
            ),

            columns: [
              const DataColumn(label: Text("Time")),
              ...days.map((day) => DataColumn(label: Text(day))),
            ],

            rows: times.map((time) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      time,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  ...days.map((day) {
                    String key = "${day}_$time";

                    return DataCell(
                      GestureDetector(
                        onTap: () {
                          String subject = schedule[key] ?? "There is no class";

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(subject)),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            schedule[key] ?? "-",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}