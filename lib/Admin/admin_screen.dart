import 'package:flutter/material.dart';
import 'package:madrasati/Admin/admin_add_exam_screen.dart';
import '../General/app_colors.dart';
import 'admin_students_screen.dart';
import 'admin_teachers_screen.dart';
import 'admin_sections_screen.dart';
import 'admin_activities_screen.dart';
import 'admin_notifications_screen.dart';
import 'admin_grades_screen.dart';
import 'admin_attendance_screen.dart';
import 'admin_class_schedule_screen.dart';
import 'admin_discipline_screen.dart';

class AdminScreen extends StatelessWidget {
  final String name;
  const AdminScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      
      // القائمة الجانبية (Drawer)
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
                  Icon(Icons.admin_panel_settings, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text("Admin Panel", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                // اكتفينا بإغلاق القائمة الجانبية فقط بناءً على طلبك 
                // لتجنب مشاكل السهم الرمادي في المتصفح
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 10),
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
                  buildCard(context, Icons.people_rounded, "Students", AdminStudentsScreen()),
                  buildCard(context, Icons.person_rounded, "Teachers", AdminTeachersScreen()),
                  buildCard(context, Icons.grid_view_rounded, "Sections", AdminSectionsScreen()),
                  buildCard(context, Icons.table_chart_rounded, "Class Schedule", const AdminClassScheduleScreen()),
                  buildCard(context, Icons.event_available_rounded, "Activities Approval", const AdminActivitiesScreen()),
                  buildCard(context, Icons.campaign_rounded, "Notifications", AdminNotificationsScreen()),
                  buildCard(context, Icons.grade_rounded, "Grades Review", AdminGradesScreen()),
                  buildCard(context, Icons.fact_check_rounded, "Attendance", AdminAttendanceScreen()),
                  buildCard(context, Icons.gavel_rounded, "Warnings &\nPenalties", const AdminPenaltiesScreen()),
                  buildCard(context, Icons.edit_calendar_rounded, "Register Exam", const AdminAddExamScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 25),
      decoration: const BoxDecoration(
        gradient: AppColors.gradient,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
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
              const Icon(Icons.admin_panel_settings, color: Colors.white, size: 28),
            ],
          ),
          const SizedBox(height: 10),
          Text("Welcome $name", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const Text("Admin Dashboard", style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Card(
        elevation: 4,
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
              child: Icon(icon, size: 35, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}