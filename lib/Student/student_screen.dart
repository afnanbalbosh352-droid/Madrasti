import 'package:flutter/material.dart';
import '../General/app_colors.dart';
import '../General/login_screen.dart'; // تأكدي أن المسار صحيح في مشروعك

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

      // ☰ القائمة الجانبية (Drawer) بتصميم مخصص
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20),
              decoration: const BoxDecoration(color: AppColors.primary),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.school_rounded, color: Colors.white, size: 50),
                  SizedBox(height: 15),
                  Text(
                    "Madrasati",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 22, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: AppColors.primary),
              title: const Text("Settings"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              title: const Text("Log out"),
              onTap: () {
                // العودة لصفحة اللوجن ومسح السجل لمنع السهم الرمادي
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), // بدون const
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // 🔵 الهيدر العلوي المتدرج مع أيقونة الإشعارات والنقطة الحمراء
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
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu_rounded, color: Colors.white),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      // 🔔 زر الإشعارات مع النقطة الحمراء
                      _buildNotificationIcon(context),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Welcome $name",
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 24, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Text("Al-Amal School", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 📦 الخدمات (GridView)
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.05,
              children: [
                // تم التأكد من عدم وجود const أمام الاستدعاءات لحل الخطوط الحمراء
                buildCard(context, Icons.event_note_rounded, "Activities", ActivitiesScreen()),
                buildCard(context, Icons.quiz_rounded, "Exam Schedule", ScheduleExamScreen()),
                buildCard(context, Icons.assignment_rounded, "Assignments", AssignmentsScreen()),
                buildCard(context, Icons.schedule_rounded, "Class Schedule", ScheduleClassScreen()),
                buildCard(context, Icons.grade_rounded, "Grades", GradesScreen()),
                buildCard(context, Icons.analytics_rounded, "Assessment", MonthlyAssessmentScreen()),
                buildCard(context, Icons.chat_bubble_outline_rounded, "Teacher Chat", TeacherListScreen()),
                buildCard(context, Icons.calendar_today_rounded, "Attendance", AttendanceScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🛠️ دالة بناء أيقونة الإشعارات مع النقطة الحمراء
  Widget _buildNotificationIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 28),
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.redAccent, 
                shape: BoxShape.circle
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة بناء الكروت
  Widget buildCard(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 34, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            Text(
              title, 
              textAlign: TextAlign.center, 
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)
            ),
          ],
        ),
      ),
    );
  }
}