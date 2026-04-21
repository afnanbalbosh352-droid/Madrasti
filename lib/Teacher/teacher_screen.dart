import 'package:flutter/material.dart';
import '../General/app_colors.dart';
import 'notifications_screen.dart';
import 'activities_teacher_screen.dart';
import 'attendance_screen.dart';
import 'teacher_assignments_screen.dart';
import 'teacher_grades_screen.dart';
import 'teacher_schedule_screen.dart';
import 'teacher_assessment_screen.dart';
import 'messages_screen.dart';

class TeacherScreen extends StatelessWidget {
  final String name;

  const TeacherScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ☰ Drawer
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Text("مدرسي", style: TextStyle(color: Colors.white)),
            ),
            ListTile(title: Text("الإعدادات")),
            ListTile(title: Text("تسجيل الخروج")),
          ],
        ),
      ),

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

                  // 🔹 Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationsScreen(),
                            ),
                          );
                        },
                        child: const Icon(Icons.notifications, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "أهلاً أستاذ $name",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    "مدرسة الأمل الحكومية",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 📦 Grid (Responsive)
            Expanded(
              child: GridView(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                children: [

                  buildCard(context, Icons.event, "Activities", ActivitiesTeacherScreen()),
                  buildCard(context, Icons.people, "Attendance", AttendanceScreen()),
                  buildCard(context, Icons.assignment, "Assignments", TeacherAssignmentsScreen()),
                  buildCard(context, Icons.grade, "Grades", TeacherGradesScreen()),
                  buildCard(context, Icons.schedule, "Schedule", TeacherScheduleScreen()),
                  buildCard(context, Icons.note, "Assessment", TeacherAssessmentScreen()),
                  buildCard(context, Icons.chat, "Messages", MessagesScreen(name: '',)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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