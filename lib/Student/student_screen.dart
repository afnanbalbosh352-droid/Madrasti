import 'package:flutter/material.dart';
import '../General/app_colors.dart';
import 'activities_screen.dart';
import 'notifications_screen.dart';
import 'schedule_exam_screen.dart';
import 'assignments_screen.dart';
import 'schedule_class_screen.dart';
import 'grades_screen.dart';
import 'monthly_assessment_screen.dart';
import 'teacher_list_screen.dart';
import 'attendance_screen.dart';

class StudentScreen extends StatelessWidget {
  final String name;

  const StudentScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: const Text(
                "Madrasati",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Setting"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Log out"),
              onTap: () { },
            ),
          ],
                ),
              
            ),
      

      body: Column(
        children: [

          // 🔵 Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 30),
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
                            builder: (_) => const  NotificationsScreen(),
                          ),
                        );
                      },
                      child: const Icon(Icons.notifications, color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 👋 Welcome
                Text(
                  "Welcome $name",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text(
                  "Al-Amal School",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // 📦 Services Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [

                  buildCard(context, Icons.event, "Activities", ActivitiesScreen()),
                  buildCard(context, Icons.quiz, "Exam Schedule", ScheduleExamScreen()),
                  buildCard(context, Icons.assignment, "Assignments", AssignmentsScreen()),
                  buildCard(context, Icons.schedule, "Class Schedule", ScheduleClassScreen()),
                  buildCard(context, Icons.grade, "Grades", GradesScreen()),
                  buildCard(context, Icons.note, "Monthly Assessment", MonthlyAssessmentScreen()),
                  buildCard(context, Icons.chat_outlined, "Teacher Chat", const TeacherListScreen()),
                  buildCard(context, Icons.calendar_today_outlined, "Attendance", const AttendanceScreen()),
                ],
              ),
            ),
          ),
        ],
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.primary),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}