import 'package:flutter/material.dart';
import '../General/app_colors.dart';
import 'admin_students_screen.dart';
import 'admin_teachers_screen.dart';
import 'admin_sections_screen.dart';
import 'admin_activities_approval_screen.dart';
import 'admin_notifications_screen.dart';
import 'admin_grades_screen.dart';
import 'admin_attendance_screen.dart';
import 'admin_reports_screen.dart';
import 'admin_class_schedule_screen.dart';

class AdminScreen extends StatelessWidget {
  final String name;

  const AdminScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [

            // 🔵 Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 25),
              decoration: const BoxDecoration(
                gradient: AppColors.gradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.admin_panel_settings, color: Colors.white),
                      Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Welcome $name",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    "Admin Dashboard",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 📦 Grid
            Expanded(
              child: GridView(
                padding: const EdgeInsets.all(16),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                children: [

                  buildCard(context, Icons.people, "Students", const AdminStudentsScreen()),
                  buildCard(context, Icons.person, "Teachers", const AdminTeachersScreen()),
                  buildCard(context, Icons.hd, "Sections", const AdminSectionsScreen()),
                  buildCard(context, Icons.table_chart, "Class Schedule", AdminClassScheduleScreen()),                  buildCard(context, Icons.event, "Activities Approval", const AdminActivitiesApprovalScreen()),
                  buildCard(context, Icons.notifications, "Notifications", const AdminNotificationsScreen()),
                  buildCard(context, Icons.grade, "Grades Review", const AdminGradesScreen()),
                  buildCard(context, Icons.fact_check, "Attendance", const AdminAttendanceScreen()),
                  buildCard(context, Icons.analytics, "Reports", const AdminReportsScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(
      BuildContext context,
      IconData icon,
      String title,
      Widget page,
      ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.primary),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}