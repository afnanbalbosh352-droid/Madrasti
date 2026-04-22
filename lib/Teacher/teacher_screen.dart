import 'package:flutter/material.dart';
import 'package:madrasati/Teacher/notifications_screen.dart';
import '../General/app_colors.dart';
import 'activities_teacher_screen.dart';
import 'attendance_screen.dart';
import 'teacher_assignments_screen.dart';
import 'teacher_grades_screen.dart';
import 'teacher_schedule_screen.dart';
import 'teacher_assessment_screen.dart';
import 'messages_screen.dart';
import 'admin_notifications_screen.dart';

class TeacherScreen extends StatelessWidget {
  final String name;

  const TeacherScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text("Madrasati", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: AppColors.primary),
              title: const Text("Settings"),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              title: const Text("Log out"),
              onTap: () {
                // Handle logout logic
              },
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // 🔵 الهيدر العلوي (Header)
            _buildHeader(context),

            const SizedBox(height: 10),

            // 📦 شبكة الأيقونات (Grid)
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
                  buildCard(context, Icons.event_note_rounded, "Activities", const ActivitiesTeacherScreen()),
                  buildCard(context, Icons.how_to_reg_rounded, "Attendance", const AttendanceScreen()),
                  buildCard(context, Icons.assignment_turned_in_rounded, "Assignments", const TeacherAssignmentsScreen()),
                  buildCard(context, Icons.insights_rounded, "Grades", const TeacherGradesScreen()),
                  buildCard(context, Icons.calendar_today_rounded, "Schedule", const TeacherScheduleScreen()),
                  buildCard(context, Icons.assessment_outlined, "Assessment", const TeacherAssessmentScreen()),
                  buildCard(context, Icons.message_rounded, "Messages", MessagesScreen(name: name)),
                  
                  // ✨ كرت إرسال الإشعارات للطلاب
                  buildCard(context, Icons.campaign_rounded, "Notification", const NotificationScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🛠️ دالة بناء الهيدر العلوي مع تفعيل زر الجرس
  Widget _buildHeader(BuildContext context) {
    return Container(
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
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              
              // 🔔 جرس الإشعارات: الآن ينتقل لشاشة إشعارات الإدارة عند الضغط
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminNotificationsScreen()),
                  );
                },
                child: const Stack(
                  children: [
                    Icon(Icons.notifications_active_outlined, color: Colors.white, size: 28),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(radius: 5, backgroundColor: Colors.red),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "Welcome Teacher $name",
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 22, 
              fontWeight: FontWeight.bold
            ),
          ),
          const Text(
            "Al-Amal school", 
            style: TextStyle(color: Colors.white70, fontSize: 14)
          ),
        ],
      ),
    );
  }

  // 🛠️ دالة بناء الكرت (Card)
  Widget buildCard(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}